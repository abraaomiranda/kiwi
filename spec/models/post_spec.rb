require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post) { FactoryGirl.build :post }

  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe 'validations' do
    context 'presence' do
      it { should validate_presence_of(:user) }
      it { should validate_presence_of(:content) }
    end

    context 'length' do
      it { should validate_length_of(:content).is_at_most(140) }
    end
  end
end
