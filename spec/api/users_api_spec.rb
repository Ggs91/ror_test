require 'rails_helper'

describe 'Users API endpoint' do

  context 'GET' do
    describe "#index" do
      it 'returns an array of serialized users' do
        user = FactoryBot.create :user
        get "/api/v1/users"

        expect(response).to have_http_status(:successful)
        expect(JSON.parse(response.body).count).not_to eq 0
        expect(JSON.parse(response.body).first['id']).to eq user.id
      end


    end
  end
end
