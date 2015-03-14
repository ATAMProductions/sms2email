class MailJob
  @queue = :mail_queue
  def self.perform(em, body, from)
    UserMailer.msg(em, body, from).deliver
  end 
end 