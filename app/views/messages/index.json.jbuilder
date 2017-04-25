json.message(@message.message)
json.date(get_datetime_jp(@message.created_at))
json.username(@message.user.name)