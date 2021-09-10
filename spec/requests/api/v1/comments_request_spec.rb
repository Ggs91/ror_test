require 'rails_helper'

RSpec.describe 'Comments API endpoint', type: :request do
before do
  @post = create(:post)
  create_list(:comment, 4, post: @post)
end
  # let(:post) { create(:post, description: 'I am the first post') }

  xcontext 'GET' do
    describe "#index" do
      before do
        create(:comment, post: post, content: 'I am the first comment')
        create_list(:comment, 4, post: post)
        get api_v1_post_comments_path(post)
      end

      it_behaves_like 'a 200 ok status'

      describe "response body" do
        it 'returns an array of serialized comments' do

          first_comment_serialized = {
            "id" => post.comments.first.id.to_s,
            "type" => "comments",
            "attributes" => {
              "content" => post.comments.first.content,
              "liked" => false,
              "total-likes" => 0
            },
            "relationships" => {
              "user" => {
                "data" => {
                  "id" => post.comments.first.user.id.to_s,
                  "type" => "users"
                }
              },
              "post" => {
                "data" => {
                  "id" => post.id.to_s,
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
        let(:path) { api_v1_post_comments_path(post) }
      end
    end
  end

  context 'POST' do
    describe "#create" do
# @post = FactoryBot.create(:post, description: 'I am the first post')

    # let(:post_resource) { create(:post) }
      # before do
      #   authenticate
      # end


      # it_behaves_like 'a 201 created status' do
      #   before { post api_v1_post_comments_path(post_resource) }
      # end

      # context "when successful request" do
        it 'creates a comment for a post' do
          expect { post api_v1_post_comments_path(@post) }.to change(@post.comments, :count).by(1)
        end
      # end

    end
  end
end
