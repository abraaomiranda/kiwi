require 'rails_helper'

RSpec.feature 'Read users', type: :feature do
  given!(:user) { FactoryGirl.create(:user) }

  scenario 'User should see the list of users' do
    other_user = FactoryGirl.create(:user)
    visit users_path

    expect(page).to have_text(user.name)
    expect(page).to have_text(other_user.name)
  end

  scenario 'User should see the page of another user' do
    visit user_path(user)

    expect(page).to have_text(user.name)
    expect(page).to have_text(user.username)
  end


end