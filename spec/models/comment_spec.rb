require 'rails_helper'

RSpec.describe Comment, type: :model do
  context 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:likes) }
  end

  context 'validations' do
    it { should validate_presence_of(:content).with_message('Content must be present') }
  end
end
