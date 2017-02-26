App.notifications = App.cable.subscriptions.create "NotificationsChannel",
  connected: ->
# Called when the subscription is ready for use on the server

  disconnected: ->
# Called when the subscription has been terminated by the server

  received: (data) ->
    $('#notificationList').prepend "#{data.notification}"
    $('#noNotifications').remove()
    $counter = $('#notificationCounter')
    val = parseInt $counter.text()
    $counter.text(val+1)
