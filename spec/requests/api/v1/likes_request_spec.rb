require 'rails_helper'

RSpec.describe 'Likes API endpoint', type: :request do

  context 'POST' do
    describe '#create' do

      before { authenticate }

      context 'when successful request' do
        context 'when post resource' do
          let(:post_resource) { create(:post) }

          before { post api_v1_post_likes_path(post_resource) }

          it_behaves_like 'a 201 created status'

          it 'creates a like for a post' do
            expect { post api_v1_post_likes_path(post_resource) }.to change(post_resource.likes, :count).by(1)
          end

          describe '"data" attribute' do
            subject { response_body['data'] }

            let(:created_like) { Like.last }

            it { is_expected.to have_id(created_like.id.to_s) }
            it { is_expected.to have_type('likes') }
            it { is_expected.to have_attribute('user-id').with_value(created_like.user.id) }
            it { is_expected.to have_attribute('created-at').with_value(created_like.created_at.as_json) }
            it { is_expected.to have_attribute('updated-at').with_value(created_like.updated_at.as_json) }
            it { is_expected.to have_attribute('likeable-type').with_value(created_like.likeable_type) }
            it { is_expected.to have_attribute('likeable-id').with_value(post_resource.id) }
          end
        end

        context 'when comment resource' do
          let(:comment_resource) { create(:comment) }

          before { post api_v1_post_comment_likes_path(comment_resource.post, comment_resource) }

          it_behaves_like 'a 201 created status'

          it 'creates a like for a comment' do
            expect { post api_v1_post_comment_likes_path(comment_resource.post, comment_resource) }.to change(comment_resource.likes, :count).by(1)
          end

          describe '"data" attribute' do
            subject { response_body['data'] }

            let(:created_like) { Like.last }

            it { is_expected.to have_id(created_like.id.to_s) }
            it { is_expected.to have_type('likes') }
            it { is_expected.to have_attribute('user-id').with_value(created_like.user.id) }
            it { is_expected.to have_attribute('created-at').with_value(created_like.created_at.as_json) }
            it { is_expected.to have_attribute('updated-at').with_value(created_like.updated_at.as_json) }
            it { is_expected.to have_attribute('likeable-type').with_value(created_like.likeable_type) }
            it { is_expected.to have_attribute('likeable-id').with_value(comment_resource.id) }
          end
        end
      end

      context 'when unsuccessful request' do
        context "when post resource doesn't exist" do
          before { post "/api/v1/posts/#{999}/likes" }

          it_behaves_like 'a 404 record not found status'

          it 'responds with error object serialized' do
            expect(response_body['errors'].first['title']).to eq('Record Not Found')
            expect(response_body['errors'].first['detail']).to eq("Couldn't find Post with 'id'=999")
            expect(response_body['errors'].first['code']).to eq(1)
          end
        end
      end
    end
  end
end
