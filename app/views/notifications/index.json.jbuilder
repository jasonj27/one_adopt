json.notifications do
  json.array! @notifications do |notification|
    # json.id notification.id
    # json.unread !notification.read_at?
    # json.template render partial: "notifications/#{notification.notifiable_type.underscore.pluralize}/#{notification.action}", locals: {notification: notification}, formats: [:html]

    json.recipient notification.recipient
    json.actor notification.actor.name
    json.action notification.action
    json.read_at notification.read_at
    json.notifiable do #notification.notifiable
      json.type "a #{notification.notifiable.class.to_s.underscore.humanize.downcase}"
    end
    json.url conversation_path(notification.notifiable.conversation, anchor: dom_id(notification.notifiable))
  end
end
json.unread_count @unread_count