module MessagesHelper
  def sms_create(body, to)
    from = ENV['TWILIOFROM']
    account_sid = ENV['TSID']
    auth_token = ENV['TTOKEN']
    client = Twilio::REST::Client.new account_sid, auth_token
    client.account.messages.create(
      :body => body,
      :to => to,
      :from => from
    )
  end
end
