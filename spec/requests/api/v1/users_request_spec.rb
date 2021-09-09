require 'rails_helper'

RSpec.describe 'Users API endpoint', type: :request do
  context 'GET' do
    describe "#index" do
      before do
        create(:user, first_name: 'Jhon', last_name: 'Doe')
        create_list(:user, 4)
        get api_v1_users_path
      end

      describe 'HTTP response status-code' do
        it_behaves_like 'a 200 ok status'
      end

      describe 'response body' do
        it 'returns an array of serialized users' do

          first_serialized_user = {
            "id" => "1",
            "type" => "users",
            "attributes" => {
              "last-name" => "Doe",
              "first-name" => "Jhon"
            }
          }

          expect(json_body["data"].count).to eq(5)
          expect(json_body['data'].first).to match(first_serialized_user)
        end
      end

      it_behaves_like 'a paginable resource' do
        let(:path) { api_v1_users_path }
      end
    end
  end
end
