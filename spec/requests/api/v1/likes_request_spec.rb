require 'rails_helper'

RSpec.describe 'Likes API endpoint', type: :request do
  context 'POST' do
    describe "#create" do
      context 'when post resource' do
        let(:resource) { create(:post) }
        it 'creates a like for a post' do

        end
      end
      # describe 'HTTP response status-code' do
      #   it_behaves_like 'a 201 created status'
      # end
    end
  end
end
