require 'rails_helper'

RSpec.feature 'User authentication', type: :feature do
  let!(:user) { FactoryGirl.create(:user) }

  scenario 'User logs in the application' do
    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    expect(page).to have_text('Logado com sucesso')
  end

  scenario 'User tries to log in with incorrect password' do
    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'incorrectpassword'
    click_button 'Log in'

    expect(page).to have_text('Email ou senha inválidos')
    expect(page).to have_button('Log in')
  end

  scenario 'Logged in user logs out' do
    login_as(user)
    visit root_path

    click_link 'Sair'

    expect(page).to have_button('Log in')
  end
end