json.array! @notifications do |notification|
    json.id notification.id
    json.from notification.from.name
    json.img notification.from.avatar.url
    json.to notification.to.name
    json.at notification.created_at
    json.reacted notification.reacted
    json.order_id notification.order_id
    json.notification_type notification.notification_type
    if notification.notification_type  === 1
        json.content notification.from.name+" added you as a friend "
    elsif notification.notification_type  === 2
        json.content notification.from.name+" invited you to his order " 
    elsif notification.notification_type === 3
        json.content notification.from.name+" joined your "
    end
    # json.content notification
    # json.url order_path(notification.order_id, anchor: dom_id(order_url))
    json.read_at notification.read_at
    # json.unread !notification.read_at?
    # json.template render partial: "/notifications/#{notification.notify_type}", locals: { notification: notification } , formats: [:html]
  
    #json.recipient notification.recipient
    #json.actor notification.actor.username
    #json.action notification.action
    #json.notifiable do #notification.notifiable
      #json.type "a #{notification.notifiable.class.to_s.underscore.humanize.downcase}"
    #end
    #json.url forum_thread_path(notification.notifiable.forum_thread, anchor: dom_id(notification.notifiable))
  end