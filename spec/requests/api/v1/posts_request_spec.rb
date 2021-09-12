require 'rails_helper'

RSpec.describe 'Posts API endpoint', type: :request do
  context 'GET' do
    describe "#index" do
      before do
        create_list(:post, 5)
        get api_v1_posts_path
      end

      it_behaves_like 'a 200 ok status'

      describe 'response body' do
        it 'returns an array of serialized posts' do
          get api_v1_posts_path

          first_post = Post.first

          first_serialized_post = {
            "id" => first_post.id.to_s,
            "type" => "posts",
            "attributes" => {
              "description" => first_post.description
            },
            "relationships" => {
              "user" => {
                "data" => {
                  "id" => first_post.user.id.to_s,
                  "type" => "users"
                }
              }
            }
          }

          expect(response_body['data'].count).to eq(5)
          expect(response_body['data'].first).to eq(first_serialized_post)
        end
      end

      it_behaves_like 'a paginable resource' do
        let(:path) { api_v1_posts_path }
      end
    end
  end
end
