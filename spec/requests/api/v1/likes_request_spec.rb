require 'rails_helper'

RSpec.describe 'Likes API endpoint', type: :request do
  context 'POST' do
    describe "#create" do
      before do
        post = create(:post)
        post api_v1_post_likes_path(post), params: { post: post }
      end

      context 'when post resource' do

        it_behaves_like 'a 201 created status'

        it 'creates a like for a post' do
        end

        it 'responds with the created resource' do

        end
      end
    end
  end
end
