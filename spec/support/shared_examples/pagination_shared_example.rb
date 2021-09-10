RSpec.shared_examples 'a paginable resource' do

  subject { json_body['data'].count }

  it 'when page=1&per_page=2' do
    get path, params: { page: 1, per_page: 2 }
    expect(subject).to eq(2)
  end

  it 'when page=1&per_page=3' do
    get path, params: { page: 1, per_page: 3 }
    expect(subject).to eq(3)
  end
end
