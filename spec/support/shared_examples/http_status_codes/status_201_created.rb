RSpec.shared_examples 'a 201 created status' do
  describe 'HTTP response status-code' do
    it 'respond with 201 created' do
      expect(response).to have_http_status(:created)
    end
  end
end


