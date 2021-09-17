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
        describe '"data" attribute' do

          it 'contains the list of requested posts' do
            expect(response_body['data'].count).to eq(5)
          end

          describe 'a serialized post' do
            subject { response_body['data'].first }

            before { get api_v1_posts_path }

            let(:first_post) { Post.first }

            it { is_expected.to have_id(first_post.id.to_s) }
            it { is_expected.to have_type('posts') }
            it { is_expected.to have_attribute('description').with_value(first_post.description) }
            it { is_expected.to have_relationship('user').with_data({
                                                           'id' => first_post.user.id.to_s,
                                                           'type' => 'users'
                                                          })
                }
          end
        end
      end

      it_behaves_like 'a paginable resource' do
        let(:path) { api_v1_posts_path }
      end
    end
  end
end
