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
        describe '"data" attribute' do
          it 'contains the list of requested users' do
            expect(response_body['data'].count).to eq(5)
          end

          describe 'a serialized user' do
            subject { response_body['data'].first }

            let(:first_user) { User.first }

            it { is_expected.to have_id(first_user.id.to_s) }
            it { is_expected.to have_type('users') }
            it { is_expected.to have_attribute('last-name').with_value(first_user.last_name) }
            it { is_expected.to have_attribute('first-name').with_value(first_user.first_name) }
          end
        end
      end

      it_behaves_like 'a paginable resource' do
        let(:path) { api_v1_users_path }
      end
    end
  end
end
