RSpec.shared_examples 'a 422 unprocessable entity status' do
  describe 'HTTP response status-code' do
    it 'respond with 422 unprocessable entity' do
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end

