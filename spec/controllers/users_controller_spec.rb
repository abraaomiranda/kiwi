require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create :user }

  describe 'GET index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'filters users if params' do
      create :user
      get :index, params: { search_by_name_or_username: user.username }

      users = controller.instance_variable_get(:@users)
      expect(users).to include user
      expect(users.size).to eq 1
    end

  end

  describe 'GET show' do
    it 'returns http success' do
      get :show, params: { id: user.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET follows' do
    it 'returns http success' do
      get :follows, params: { id: user.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET followers' do
    it 'returns http success' do
      get :followers, params: { id: user.id }
      expect(response).to have_http_status(:success)
    end
  end

end
