module ChatsHelper
  def members_string
    "Members: #{@group.users.pluck(:name).join(", ")}"
  end

  def japanese_datetime(datetime)
    datetime.strftime("%Y/%m/%d(#{%w(日 月 火 水 木 金 土)[datetime.wday]}) %X")
  end
end
