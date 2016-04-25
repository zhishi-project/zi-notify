class EmailService < BaseNotificationService
  def inform(user, resource:)
    if user.email
      mail_params = attachment_option_for_user(user, resource, :email)
      NotificationsMailer.notify_by_mail(mail_params, to: user.email).deliver_now
    end
  end
end
