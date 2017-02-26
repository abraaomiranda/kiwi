require 'rails_helper'

RSpec.feature 'Notification Management', type: :feature do
  given(:user) { create :user }
  given(:other_user) { create :user, name: 'George Harrison' }
  given!(:notification) { create :notification, owner: other_user }

  scenario 'User should see a notification when followed' do
    login_as(notification.recipient)
    visit root_path

    expect(page).to have_text("#{other_user.name} #{notification.message}")
  end

  scenario 'A notification should be created when a user is followed' do
    another_user = create :user
    login_as(user)
    visit user_path(another_user)

    expect{ click_button 'Seguir' }.to change{Notification.count}.by(1)
  end

  scenario 'Logged in user should see his own notifications' do
    notified_user = notification.recipient
    login_as notified_user
    visit root_path

    within('#notificationList') do
      click_link 'Ver mais'
    end

    expect(page).to have_current_path(notifications_path)
    expect(page).to have_text("#{other_user.name} #{notification.message}")
  end

  scenario 'Logged in user should not see notifications for another user' do
    login_as user
    visit notifications_path

    expect(page).to_not have_text("#{other_user.name} #{notification.message}")
  end

  scenario 'logged in user should see number of not read notifications on navigation bar' do
    login_as notification.recipient
    visit root_path

    expect(find('#notificationCounter')).to have_text('1')
  end
end