require 'rails_helper'

RSpec.describe 'Comments API endpoint', type: :request do

  let(:post_resource) { create(:post, description: 'I am the first post') }

  context 'GET' do
    describe "#index" do
      before do
        create(:comment, post: post_resource, content: 'I am the first comment')
        create_list(:comment, 4, post: post_resource)
        get api_v1_post_comments_path(post_resource)
      end

      it_behaves_like 'a 200 ok status'

      describe "response body" do
        it 'returns an array of serialized comments' do

          first_comment_serialized = {
            "id" => post_resource.comments.first.id.to_s,
            "type" => "comments",
            "attributes" => {
              "content" => post_resource.comments.first.content,
              "liked" => false,
              "total-likes" => 0
            },
            "relationships" => {
              "user" => {
                "data" => {
                  "id" => post_resource.comments.first.user.id.to_s,
                  "type" => "users"
                }
              },
              "post" => {
                "data" => {
                  "id" => post_resource.id.to_s,
                  "type" => "posts"
                }
              }
            }
          }

          expect(response_body['data'].count).to eq(5)
          expect(response_body['data'].first).to eq(first_comment_serialized)
        end

        it 'includes the associated objects' do
          expect(response_body).to have_key('included')
          expect(response_body['included']).not_to eq(0)
        end

        it 'has a "self" key' do
          expect(response_body).to have_key('links')
          expect(response_body['links']).to have_key('self')
        end
      end

      it_behaves_like 'a paginable resource' do
        let(:path) { api_v1_post_comments_path(post_resource) }
      end
    end
  end

  context 'POST' do
    describe "#create" do
      let(:params) { { comment: { content: 'My first comment'} } }

      before { post api_v1_post_comments_path(post_resource), params: params }

      context ' when successful request' do
        it_behaves_like 'a 201 created status'

        it 'creates a comment for a post' do
          expect { post api_v1_post_comments_path(post_resource), params: params }.to change(post_resource.comments, :count).by(1)
        end

        it 'responds with the created comment object serialized' do

          created_comment = Comment.last

          last_comment_serialized = {
              "data" => {
                "id" => created_comment.id.to_s,
                "type" => "comments",
                "attributes" => {
                  "content" => created_comment.content,
                  "user-id" => created_comment.user.id,
                  "post-id" => created_comment.post.id,
                  "created-at" => created_comment.created_at.as_json,
                  "updated-at" => created_comment.updated_at.as_json,
                  "likes-count" => 0
                },
              },
              "links" => {
                "self" => "http://#{host}/api/v1/posts/#{post_resource.id}/comments/#{created_comment.id}"
              }
          }
          expect(response_body).to eq(last_comment_serialized)
        end
      end

      context 'when failed request' do
        describe 'when params is missing' do
          it_behaves_like 'a 400 bad request status' do
            before { post api_v1_post_comments_path(post_resource), params: {} }
          end
        end

        describe "when post resource doesn't exist" do
          before { post "/api/v1/posts/#{999}/comments" }

          it_behaves_like 'a 404 record not found status'

          it "responds with error object serialized" do
            expect(response_body['errors'].first['title']).to eq('Record Not Found')
            expect(response_body['errors'].first['code']).to eq(1)
            expect(response_body['errors'].first['detail']).to eq("Couldn't find Post with 'id'=999")
          end
        end
      end
    end
  end
end
