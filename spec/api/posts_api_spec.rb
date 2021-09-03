require 'rails_helper'

describe 'Posts API endpoint' do

  context 'GET' do
    describe "#index" do
      it 'returns an array of serialized posts' do
        post = FactoryBot.create :post
        get "/api/v1/posts"

        expect(response).to have_http_status(:successful)
        expect(JSON.parse(response.body).count).not_to eq 0
        expect(JSON.parse(response.body).first['id']).to eq post.id
      end


    end
  end
end
