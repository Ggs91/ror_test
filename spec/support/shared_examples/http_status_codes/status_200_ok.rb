RSpec.shared_examples 'a 200 ok status' do
  it 'respond with 200 ok' do
    expect(response).to have_http_status(:ok)
  end
end
