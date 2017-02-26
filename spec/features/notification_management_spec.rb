require 'rails_helper'

RSpec.feature 'Notification Management', type: :feature do
  given(:user) { create(:user) }

  scenario 'User should see a notification when followed' do
    notification = create :notification, recipient: user
    login_as(user)
    visit root_path

    expect(page).to have_text("#{notification.owner.name} #{notification.message}")
  end

  scenario 'A notification should be created when a user is followed' do
    another_user = create :user
    login_as(user)
    visit user_path(another_user)

    click_button 'Seguir'

    expect(Notification.count).to eql 1
  end


end