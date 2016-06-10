class EmailService < BaseNotificationService
  def inform(user, resource:)
    if user.email
      mail_params = attachment_option_for_user(user, resource, :email)
      EmailWrapper::Mailer.send(mail_params)
    end
  end
end
