json.array!(@congressional_notifications) do |congressional_notification|
  json.extract! congressional_notification, :id, :name, :cn_number
  json.url congressional_notification_url(congressional_notification, format: :json)
end
