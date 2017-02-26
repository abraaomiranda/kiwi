require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:user) { create :user }
  let(:valid_attributes) { { post: { content: 'Witness me!!' } } }
  let(:invalid_attributes) { { post: { content: nil } } }

  describe 'POST create' do
    include_examples 'requires authentication' do
      let(:action) { post :create, params: valid_attributes }
    end

    describe 'with valid params' do
      before { sign_in user }

      it 'redirect to home page' do
        post :create, params: valid_attributes
        expect(response).to redirect_to(home_index_path)
      end

      it 'create a post' do
        expect { post :create, params: valid_attributes }.
            to change(Post, :count).by(1)
      end
    end

    describe 'with invalid params' do
      before { sign_in user }

      it 'not create a post' do
        post :create, params: invalid_attributes

        expect(Post.count).to eq 0
      end
    end
  end

  describe 'DELETE destroy' do
    let!(:user_post) { create :post, author: user }
    include_examples 'requires authentication' do
      let(:action) { post :destroy, params: { id: 1 } }
    end

    it 'destroy a post' do
      sign_in user
      expect { post :destroy, params: { id: user_post.id } }.
          to change(Post, :count).by(-1)
    end

    it 'redirect to followed profile' do
      sign_in user
      post :destroy, params: { id: user_post.id }

      expect(response).to redirect_to(home_index_path)
    end
  end

end
