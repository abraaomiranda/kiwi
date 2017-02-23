require 'rails_helper'

RSpec.feature 'User management', type: :feature do
  given(:user) { create(:user) }

  scenario 'User sign up' do
    visit new_user_registration_path

    fill_in 'Nome', with: 'Test Example'
    fill_in 'Usuário', with: 'tesname'
    fill_in 'Email', with: 'test@email.com'
    fill_in 'Senha', with: 'secretpassword'
    fill_in 'Confirme sua senha', with: 'secretpassword'
    click_button 'Cadastrar'

    expect(page).to have_text('Bem-vindo! Você se registrou com sucesso.')
  end

  scenario 'User update his profile with valid params' do
    login_as(user)
    visit edit_user_registration_path

    fill_in 'Usuário', with: 'newusername'
    fill_in 'Nome', with: 'New Example'
    fill_in 'Email', with: 'new@email.com'
    fill_in 'Nova senha', with: 'newsecretpassword'
    fill_in 'Confirmar nova senha', with: 'newsecretpassword'
    fill_in 'Senha atual', with: user.password
    click_button 'Atualizar'

    expect(page).to have_text('Sua conta foi atualizada com sucesso.')
  end

  scenario 'User tries to update his profile with invalid params' do
    login_as(user)
    visit edit_user_registration_path

    fill_in 'Usuário', with: 'newusername'
    fill_in 'Nome', with: 'New Example'
    fill_in 'Email', with: 'new@email.com'
    fill_in 'Nova senha', with: 'newsecretpassword'
    fill_in 'Confirmar nova senha', with: 'newsecretpassword'
    fill_in 'Senha atual', with: 'wrongpassword'
    click_button 'Atualizar'

    expect(page).to have_text('Por favor, verifique os problemas abaixo:')
  end

  scenario 'User cancel his registration' do
    login_as(user)
    visit edit_user_registration_path

    click_link 'Cancelar minha conta'

    expect(page). to have_current_path(new_user_session_path)
    expect(page). to have_text('Você precisa fazer login ou se registrar, antes de continuar.')
    expect(User.count). to eql 0
  end

  scenario 'User tries to recover password with invalid params' do
    visit new_user_password_path

    fill_in 'Email', with: 'wrong@email.com'
    click_button 'Me envie instruções'

    expect(page). to have_text('Por favor, verifique os problemas abaixo')
  end

  scenario 'User tries to recover password with valid params' do
    visit new_user_password_path

    fill_in 'Email', with: user.email
    click_button 'Me envie instruções'

    expect(page). to have_text('Você receberá um e-mail com instruções sobre como redefinir sua senha em poucos minutos.')
  end

end