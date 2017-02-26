require 'rails_helper'

RSpec.describe NotificationsController, type: :controller do
  let(:user) { create :user }

  describe 'GET index' do
    include_examples 'requires authentication' do
      let(:action) { get :index }
    end

    context 'with user logged in' do
      before { sign_in user }

      it 'returns http success' do
        get :index
        expect(response).to have_http_status(:success)
      end

      it 'mark all users notifications as read' do
        create :notification, recipient: user
        expect { get :index }.
            to change(Notification.where(read: true), :count).
                by(1)
      end
    end
  end
end
