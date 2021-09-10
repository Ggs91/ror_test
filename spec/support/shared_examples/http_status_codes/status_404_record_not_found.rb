RSpec.shared_examples 'a 404 record not found status' do
  describe 'HTTP response status-code' do
    it 'respond with 404 record not found status' do
      expect(response).to have_http_status(:not_found)
    end
  end
end

