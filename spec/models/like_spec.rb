require 'rails_helper'

RSpec.describe Like, type: :model do
  context 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:likeable).counter_cache(:likes_count) }
  end
end
