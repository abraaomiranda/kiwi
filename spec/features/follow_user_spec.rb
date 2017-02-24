require 'rails_helper'

RSpec.feature 'Follow user', type: :feature do
  given(:user) { create(:user) }

  scenario 'Logged in user should follow another user' do
    other_user = create(:user)
    login_as(user)
    visit user_path(other_user)

    click_button 'Seguir'

    expect(page).to have_text('Você está seguindo essa pessoa')
    expect(page).to have_current_path(user_path(other_user))
  end

  scenario 'Not logged in user tries to follow user' do
    visit user_path(user)

    click_button 'Seguir'

    expect(page).to have_text('Você precisa fazer login ou se registrar, antes de continuar.')
    expect(page).to have_current_path(new_user_session_path)
  end

  scenario 'Unfollow another user' do
    follow = create :follow
    login_as(follow.follower)
    visit user_path(follow.followed)

    click_button 'Deixar de seguir'

    expect(page).to have_text('Você não está mais seguindo essa pessoa')
    expect(page).to have_current_path(user_path(follow.followed))
  end


end