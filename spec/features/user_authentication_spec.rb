require 'rails_helper'

RSpec.feature 'User authentication', type: :feature do
  given!(:user) { FactoryGirl.create(:user) }

  scenario 'User logs in using email' do
    visit new_user_session_path

    fill_in 'Login', with: user.email
    fill_in 'Senha', with: user.password
    click_button 'Entrar'

    expect(page).to have_text('Logado com sucesso')
  end

  scenario 'User logs in using username' do
    visit new_user_session_path

    fill_in 'Login', with: user.username
    fill_in 'Senha', with: user.password
    click_button 'Entrar'

    expect(page).to have_text('Logado com sucesso')
  end

  scenario 'User tries to log in with incorrect password' do
    visit new_user_session_path

    fill_in 'Login', with: user.email
    fill_in 'Senha', with: 'incorrectpassword'
    click_button 'Entrar'

    expect(page).to have_text('Email ou senha inválidos')
    expect(page).to have_button('Entrar')
  end

  scenario 'Logged in user logs out' do
    login_as(user)
    visit root_path

    click_link 'Sair'

    expect(page).to have_button('Entrar')
  end
end