json.username(@message.user.name)
json.date(get_datetime_jp(@message.created_at))
json.image(@message.image)
json.message(@message.message)
