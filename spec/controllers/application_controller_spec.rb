require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  controller do
    before_action :set_unread_notifcations, only: :index, if: :user_signed_in?
    before_action :configure_permitted_parameters, only: :index, if: :devise_controller?

    def index
      render plain: 'Ok'
    end
  end
  describe 'before_action' do
    describe '#set_unread_notifications' do
      it 'returns http success' do
        sign_in create(:user)
        get :index
        expect(response).to have_http_status(:success)
      end
    end

    describe '#configure_permitted_parameters' do
      it 'change permited params' do
        allow(controller).to receive(:devise_controller?).and_return(true)
        allow(controller).to receive(:devise_parameter_sanitizer).and_return(ActionController::Parameters.new)

        expect(controller.devise_parameter_sanitizer).to receive(:permit).twice
        get :index
      end
    end
  end
end
