module ChatsHelper
  def get_group_members(group)
    group.users.pluck(:name).join(", ")
  end

  def get_datetime_jp(datetime)
    datetime.strftime("%Y/%m/%d(#{%w(日 月 火 水 木 金 土)[datetime.wday]}) %X")
  end

  def get_recent_message(group)
    message = group.messages.order(:created_at).reverse_order.pluck(:message).first

    if message.blank?
      message = 'まだメッセージはありません'
    end

    return message
  end
end
