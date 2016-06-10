module EmailWrapper
  class Mailer
    class << self
      def send(mail_params)
        mail to: mail_params[:to],
             subject: mail_params[:subject],
             body: mail_params[:body],
             content_type: "text/html"
      end
    end
  end
end