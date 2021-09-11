RSpec.shared_examples 'a 400 bad request status' do
  describe 'HTTP response status-code' do
    it 'respond with 400 bad request' do
      expect(response).to have_http_status(:bad_request)
    end
  end
end

