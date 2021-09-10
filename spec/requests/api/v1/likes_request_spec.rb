require 'rails_helper'

RSpec.describe 'Likes API endpoint', type: :request do

  context 'POST' do
    describe "#create" do

      before { authenticate }

      context "when successful request" do
        context 'when post resource' do
          let(:post_resource) { create(:post) }

          it_behaves_like 'a 201 created status' do
            before { post api_v1_post_likes_path(post_resource) }
          end

          it 'creates a like for a post' do
            expect { post api_v1_post_likes_path(post_resource) }.to change(post_resource.likes, :count).by(1)
          end

          it 'responds with the created like object serialized' do
            post api_v1_post_likes_path(post_resource)

            created_like = Like.last

            last_like_serialized = {
              "data" => {
                "id" => created_like.id.to_s,
                "type" => "likes",
                "attributes" => {
                  "user-id" => created_like.user.id,
                  "created-at" => created_like.created_at.as_json,
                  "updated-at" => created_like.updated_at.as_json,
                  "likeable-type" => created_like.likeable_type,
                  "likeable-id" => post_resource.id
                }
              }
            }
            expect(response_body).to eq(last_like_serialized)
          end
        end

        context 'when comment resource' do
          let(:comment_resource) { create(:comment) }

          it_behaves_like 'a 201 created status' do
            before { post api_v1_post_comment_likes_path(comment_resource.post, comment_resource) }
          end

          it 'creates a like for a comment' do
            expect { post api_v1_post_comment_likes_path(comment_resource.post, comment_resource) }.to change(comment_resource.likes, :count).by(1)
          end

          it 'responds with the created comment object serialized' do
            post api_v1_post_comment_likes_path(comment_resource.post, comment_resource)

            created_like = Like.last

            last_like_serialized = {
              "data" => {
                "id" => created_like.id.to_s,
                "type" => "likes",
                "attributes" => {
                  "user-id" => created_like.user.id,
                  "created-at" => created_like.created_at.as_json,
                  "updated-at" => created_like.updated_at.as_json,
                  "likeable-type" => created_like.likeable_type,
                  "likeable-id" => comment_resource.id
                }
              }
            }
            expect(response_body).to eq(last_like_serialized)
          end
        end
      end

      context "when unsuccessful request" do
        context "when post resource doesn't exist" do
          before { post "/api/v1/posts/#{999}/likes" }

          it_behaves_like 'a 404 record not found status'

          it "responds with error object serialized" do
            expect(response_body['errors'].first['title']).to eq('Record Not Found')
            expect(response_body['errors'].first['detail']).to eq("Couldn't find Post with 'id'=999")
            expect(response_body['errors'].first['code']).to eq(1)
          end
        end
      end
    end
  end
end
