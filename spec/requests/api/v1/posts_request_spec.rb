require 'rails_helper'

RSpec.describe 'Posts API endpoint', type: :request do
  context 'GET' do
    describe "#index" do
      before do
        create(:post, description: 'I am the first post')
        create_list(:post, 4)
      end

      it_behaves_like 'a 200 ok status' do
        before { get api_v1_posts_path }
      end

      describe 'response body' do
        it 'returns an array of serialized posts' do
          get api_v1_posts_path

          first_serialized_post = {
            "id" => "1",
            "type" => "posts",
            "attributes" => {
              "description" => "I am the first post"
            },
            "relationships" => {
              "user" => {
                "data" => {
                  "id" => "1",
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
