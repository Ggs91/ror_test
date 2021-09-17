require 'rails_helper'

RSpec.describe 'Comments API endpoint', type: :request do

  let(:post_resource) { create(:post) }

  context 'GET' do
    describe "#index" do
      before do
        create_list(:comment, 5, post: post_resource)
        get api_v1_post_comments_path(post_resource)
      end

      it_behaves_like 'a 200 ok status'

      describe 'response body' do
        describe '"data" attribute' do
          it 'contains the list of requested comments' do
            expect(response_body['data'].count).to eq(5)
          end

          describe 'a serialized comment' do
            subject { response_body['data'].first }

            it { is_expected.to have_id(post_resource.comments.first.id.to_s) }
            it { is_expected.to have_type('comments') }
            it { is_expected.to have_jsonapi_attributes('content', 'liked', 'total-likes') }
            it { is_expected.to have_attribute('content').with_value(post_resource.comments.first.content) }
            it { is_expected.to have_relationships('user', 'post') }
            it { is_expected.to have_relationship('user').with_data({
                                                           'id' => post_resource.comments.first.user.id.to_s,
                                                           'type' => 'users'
                                                          })
                }
            it { is_expected.to have_relationship('post').with_data({
                                                           'id' => post_resource.id.to_s,
                                                           'type' => 'posts'
                                                          })
                }
          end
        end

        describe '"included" attribute' do
          it 'has an included attribute' do
            expect(response_body).to have_key('included')
          end

          it 'includes the associated objects' do
            expect(response_body['included']).not_to eq(0)
          end
        end

        describe '"links" attribute' do
          it 'has a links attribute' do
            expect(response_body).to have_key('links')
          end

          it 'has a "self" key' do
            expect(response_body['links']).to have_key('self')
          end
        end

        it_behaves_like 'a paginable resource' do
          let(:path) { api_v1_post_comments_path(post_resource) }
        end
      end
    end
  end

  context 'POST' do
    describe "#create" do
      let(:params) { { comment: { content: 'My first comment'} } }

      before { post api_v1_post_comments_path(post_resource), params: params }

      context 'when successful request' do
        let(:created_comment) { Comment.last }

        it_behaves_like 'a 201 created status'

        it 'creates a comment for a post' do
          expect { post api_v1_post_comments_path(post_resource), params: params }.to change(post_resource.comments, :count).by(1)
        end

        describe 'response body' do
          describe '"links" attribute' do
            it 'has a "self" key' do
              expect(response_body['links']['self']).to eq("http://#{host}/api/v1/posts/#{post_resource.id}/comments/#{created_comment.id}")
            end
          end

          describe '"data" attribute' do
            subject { response_body['data'] }

            it { is_expected.to have_id(created_comment.id.to_s) }
            it { is_expected.to have_type('comments') }
            it { is_expected.to have_attribute('content').with_value(created_comment.content) }
            it { is_expected.to have_attribute('user-id').with_value(created_comment.user.id) }
            it { is_expected.to have_attribute('post-id').with_value(created_comment.post.id) }
            it { is_expected.to have_attribute('created-at').with_value(created_comment.created_at.as_json) }
            it { is_expected.to have_attribute('updated-at').with_value(created_comment.updated_at.as_json) }
            it { is_expected.to have_attribute('likes-count').with_value(0) }
          end
        end
      end

      context 'when failed request' do
        describe 'when params is missing' do
          it_behaves_like 'a 400 bad request status' do
            before { post api_v1_post_comments_path(post_resource), params: {} }
          end
        end

        describe "when post resource doesn't exist" do
          before { post "/api/v1/posts/#{999}/comments" }

          it_behaves_like 'a 404 record not found status'

          it "responds with error object serialized" do
            expect(response_body['errors'].first['title']).to eq('Record Not Found')
            expect(response_body['errors'].first['code']).to eq(1)
            expect(response_body['errors'].first['detail']).to eq("Couldn't find Post with 'id'=999")
          end
        end
      end
    end
  end
end
