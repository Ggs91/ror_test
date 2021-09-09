require 'rails_helper'

RSpec.describe 'Posts API endpoint', type: :request do
  context 'GET' do
    describe "#index" do
      before do
        create(:post, description: 'I am the first post')
        create_list(:post, 4)
        get api_v1_posts_path
      end

      describe 'HTTP response status-code' do
        it_behaves_like 'a 200 ok status code'
      end

      describe 'response body' do
        it 'returns an array of serialized posts' do

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

          expect(json_body["data"].count).to eq(5)
          expect(json_body['data'].first).to match(first_serialized_post)
        end
      end

      it_behaves_like 'a paginable resource' do
        let(:path) { api_v1_posts_path }
      end
    end
  end
end
