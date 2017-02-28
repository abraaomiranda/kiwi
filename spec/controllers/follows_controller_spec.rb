require 'rails_helper'

RSpec.describe FollowsController, type: :controller do
  let(:follower) { create :user }
  let(:followed) { create :user }
  let(:valid_attributes) { {follow: { followed_id: followed.id }} }
  let(:invalid_attributes) { {follow: { followed_id: nil }} }

  describe 'POST create' do
    include_examples 'requires authentication' do
      let(:action) { post :create, params: valid_attributes }
    end

    describe 'with valid params' do
      before { sign_in follower }

      it 'redirect to followed profile' do
        post :create, params: valid_attributes
        expect(response).to redirect_to(user_path(followed))
      end

      it 'create a follow' do
        expect { post :create, params: valid_attributes }.
            to change(Follow, :count).by(1)
      end

      it 'create a notification' do
        expect { post :create, params: valid_attributes }.
            to change(Notification, :count).by(1)
      end
    end

    describe 'with invalid params' do
      before { sign_in follower }

      it 'not create a follow' do
        post :create, params: invalid_attributes

        expect(Follow.count).to eq 0
      end
    end
  end

  describe 'DELETE destroy' do
    let!(:follow) { create :follow, follower: follower, followed: followed }
    include_examples 'requires authentication' do
      let(:action) { delete :destroy, params: { id: 1 } }
    end

    it 'destroy a follow' do
      sign_in follower
      expect { delete :destroy, params: { id: follow.id } }.
          to change(Follow, :count).by(-1)
    end

    it 'redirect to followed profile' do
      sign_in follower
      delete :destroy, params: { id: follow.id }

      expect(response).to redirect_to(user_path(followed))
    end
  end

end
