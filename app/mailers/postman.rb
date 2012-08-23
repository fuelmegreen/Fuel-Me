class Postman < ActionMailer::Base
  default from: RConfig.communications.no_reply
  
  ## COMMUNICATIONS ##########

  def join_beta(user)
    send_response(user, 'FuelMe: Thank you for joinging our Beta!')
  end

  def post_comment(comment)
    send_response(comment)
  end

  def send_response(user, subject=nil)
    @user = user
    @settings = settings
    mail(to: email(user), subject: subject || settings.response.subject)
  end

  ## NOTIFICATIONS ##########

  def comment_notification(comment)
    @comment = comment
    notification('New Comment Posted')
  end

  def unsubscribe_notification(user)
    @email = user.try(:email) || user
    notification("UNSUBSCRIBE: #{@email}")
  end

  def notification(subject)
    mail to: settings.emails.support, subject: subject
  end

  ## Helper Methods ##########

  def settings
    @settings ||= RConfig.communications
  end

  def email(user)
    user.name.present? ? "#{user.name} <#{user.email}>" : user.email
  end

end


