module ChatsHelper
  def get_members_string_by_group(group)
    "Members: #{group.users.pluck(:name).join(", ")}"
  end

  def get_japanese_datetime_by_datetime(datetime)
    datetime.strftime("%Y/%m/%d(#{%w(日 月 火 水 木 金 土)[datetime.wday]}) %X")
  end
end
