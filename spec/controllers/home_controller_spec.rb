require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  let!(:user) { create :user }

  describe 'GET index' do
    include_examples 'requires authentication' do
      let(:action) { get :index }
    end

    it 'returns http success' do
      sign_in user
      get :index
      expect(response).to have_http_status(:success)
    end

  end

end
