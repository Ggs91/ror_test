require 'rails_helper'

RSpec.describe 'Users API endpoint', type: :request do
  context 'GET' do
    describe "#index" do
      before do
        create_list(:user, 5)
        get api_v1_users_path
      end

      it_behaves_like 'a 200 ok status'

      describe 'response body' do
        it 'returns an array of serialized users' do

          first_user = User.first

          first_serialized_user = {
            "id" => first_user.id.to_s,
            "type" => "users",
            "attributes" => {
              "last-name" => first_user.last_name,
              "first-name" => first_user.first_name
            }
          }

          expect(response_body['data'].count).to eq(5)
          expect(response_body['data'].first).to match(first_serialized_user)
        end

        it 'has a "self" key' do
          expect(response_body).to have_key('links')
          expect(response_body['links']).to have_key('self')
        end
      end

      it_behaves_like 'a paginable resource' do
        let(:path) { api_v1_users_path }
      end
    end
  end
end
