class NotificationsMailer < ActionMailer::Base

  default :from => "your_email_here"
  default :to => "your_email_here"

  def new_message(message)
    @message = message
    mail(:subject => "Coursify: #{message.name}", reply_to: '#{message.email}')
  end

end