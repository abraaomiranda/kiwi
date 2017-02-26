require 'rails_helper'

RSpec.feature 'Search users', type: :feature do
  given!(:wally) { create :user, name:'Wally', username: 'wheres_waldo' }
  given!(:eva) { create :user, name:'Eva', username: 'wall_e_movie' }

  scenario 'Search user by name' do
    visit users_path

    fill_in 'search_index_input', with: 'wally'
    click_button 'search_index_button'

    expect(page).to have_text(wally.username)
    expect(page).to_not have_text(eva.username)
  end

  scenario 'Search user by username' do
    visit users_path

    fill_in 'search_index_input', with: 'wall_e'
    click_button 'search_index_button'

    expect(page).to have_text(eva.name)
    expect(page).to_not have_text(wally.name)
  end

  scenario 'Search user by commom text' do
    visit users_path

    fill_in 'search_index_input', with: 'wall'
    click_button 'search_index_button'

    expect(page).to have_text(eva.name)
    expect(page).to have_text(wally.name)
  end

  scenario 'Search user through navigation bar form' do
    visit users_path

    fill_in 'search_navbar_input', with: 'wall'
    click_button 'search_navbar_button'

    expect(page).to have_text(eva.name)
    expect(page).to have_text(wally.name)
  end

end