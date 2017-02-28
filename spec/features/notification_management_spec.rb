require 'rails_helper'

RSpec.feature 'Notification Management', type: :feature do
  given(:other_user) { create :user, name: 'George Harrison' }
  given!(:notification) { create :notification, owner: other_user }

  scenario 'User should see a notification when followed' do
    login_as(notification.recipient)
    visit root_path

    expect(page).to have_text("#{other_user.name} #{notification.message}")
  end

  scenario 'Logged in user should see his own notifications' do
    login_as notification.recipient
    visit root_path

    within('#notificationList') do
      expect(page).to have_text("#{other_user.name} #{notification.message}")
    end
  end

  scenario 'Logged in user should not see notifications for another user' do
    login_as create :user
    visit notifications_path

    expect(page).to_not have_text("#{other_user.name} #{notification.message}")
  end

  scenario 'logged in user should see number of not read notifications on navigation bar' do
    create :notification, recipient: notification.recipient, read: true
    login_as notification.recipient
    visit root_path

    expect(find('#notificationCounter')).to have_text('1')
  end

  scenario 'Logged in user should list its own notifications' do
    login_as notification.recipient
    visit root_path

    within('#notificationList') do
      click_link 'Ver mais'
    end

    expect(page).to have_current_path(notifications_path)
    expect(page).to have_text("#{other_user.name} #{notification.message}")
  end
end