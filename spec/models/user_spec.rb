require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) { FactoryGirl.build :user }

  describe 'associations' do
    it { should have_many(:posts) }
  end

  describe 'validations' do
    context 'presence' do
      it { should validate_presence_of(:username) }
      it { should validate_presence_of(:email) }
      it { should validate_presence_of(:name) }
    end

    context 'uniqueness' do
      it { should validate_uniqueness_of(:username).case_insensitive }
      it { should validate_uniqueness_of(:email).case_insensitive }
    end

    context 'length' do
      it { should validate_length_of(:password).is_at_least(6) }
    end

    context 'format' do
      it { should allow_value('cslewis@email.com').
          for(:email) }
      it { should_not allow_value('george.martin@email@com.br').
          for(:email) }
    end
  end

  describe '.find_for_database_authentication' do
    describe 'should return existing user' do
      let(:george) { create :user, username: 'geroge_martin', email: 'gege@email.com' }
      let(:lewis) { create :user, username: 'cslewis', email: 'lewis@email.com' }

      it 'by email' do
        expect(User.find_for_database_authentication(email:george.email)).to eql george
      end

      it 'by username' do
        expect(User.find_for_database_authentication(username:lewis.username)).to eql lewis
      end

      it 'by login' do
        expect(User.find_for_database_authentication(login:lewis.username)).to eql lewis
        expect(User.find_for_database_authentication(login:george.email)).to eql george
      end
    end
  end

end
