class NotificationsMailer < ActionMailer::Base
  def cleaned_template
    template_file = File.read("template.htm.erb")
    ERB.new(template_file).result(binding)
  end

  def binding(template_values)
    OpenStruct.new(template_values)
  end

  def notify_by_mail(mail_params, to:)
    mail to: to,
         from: "Zhishi <zhishi@andela.com>",
         subject: mail_params[:subject],
         body: mail_params[:body],
         content_type: "text/html"
  end
end