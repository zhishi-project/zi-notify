class NotificationsMailer < ActionMailer::Base
  def notify_by_mail(mail_params, to:)
    mail to: to,
         from: "Zhishi <zhishi@andela.com>",
         subject: mail_params[:subject],
         body: mail_params[:body],
         content_type: "text/html"
  end
end