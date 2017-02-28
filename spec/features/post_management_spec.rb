require 'rails_helper'

RSpec.feature 'Post management', type: :feature do
  given(:user) { create(:user) }

  scenario 'Logged in user should create a post with valid params' do
    login_as(user)
    visit root_path

    fill_in 'post_content', with: 'New post!'
    click_button 'Postar'

    expect(page).to have_text('New post!')
  end

  scenario 'User page should show his posts' do
    post = create(:post, author: user)
    visit user_path(user)

    expect(page).to have_text(post.content)
  end

  scenario 'Logged in user tries to create a post with invalid params' do
    login_as(user)
    visit root_path

    click_button 'Postar'

    expect(page).to have_text('Conteúdo não pode ficar em branco')
  end

  scenario 'Logged in user should delete his own posts' do
    create(:post, author: user)
    login_as(user)
    visit root_path

    click_button 'x'

    expect(page).to have_text('Post deletado com sucesso')

  end
end