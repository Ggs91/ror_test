RSpec.shared_examples 'a paginable resource' do

  describe 'numbre of requested objects' do
    subject { response_body['data'].count }

    context 'when page=1&per_page=2' do
      before { get path, params: { page: 1, per_page: 2 } }

      it { is_expected.to eq(2) }
    end

    context 'when page=1&per_page=3' do
      before { get path, params: { page: 1, per_page: 3 } }

      it { is_expected.to eq(3) }
    end
  end

  describe 'links keys' do
    it 'has json api keys' do
      expect(response_body['links']).to include('first', 'prev', 'next', 'last')
    end
  end
end
