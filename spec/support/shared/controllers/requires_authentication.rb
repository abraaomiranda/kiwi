RSpec.shared_examples 'requires authentication' do
  it 'redirects to login page if user not logged in' do
    action

    expect(response).to redirect_to new_user_session_path
  end
end
