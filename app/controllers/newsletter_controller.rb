class NewsletterController < ApplicationController
  def receive
    mail_questions = []
    questions.each do |question|
      mail_questions << question
    end

    newsletter = {}
    newsletter[:mail_questions] = mail_questions
    send_mail(newsletter)
  end

  def send_mail(newsletter)
    mail_params = {}
    mail_params[:subject] = "Zhishi Weekly Newsletter"
    mail_params[:body] = EmailWrapper::NewsletterDesigner.format_content(newsletter)  

    emails.each do |email|
      NewsletterMailer.notify_by_mail(mail_params, to: email).deliver
    end
  end

  def emails
    [
      # "olaide.ojewale@andela.com",
      # "osmond.oranagwa@andela.com",
      # "oreoluwa.akinniranye@andela.co",
      # "emmanuel.chigbo@andela.com",
      "tobi.oduah@andela.com"
      # "adebayo.adepoju@andela.com"
    ]
  end

  def questions
    [
      OpenStruct.new({
        asked_by: "Tobi Oduah",
        asked_on: "Sat, May 1, 2016",
        title: "Is there a recommended format for writing the skilltree biography?",
        content: "<div data-reactid=\".0.0.0.1.0.0.1.0.1.1.0\">\n<p>I noticed the \"Bio\" section of skilltree with different people using different approaches to write theirs, and I was wondering if there is a recommended format for it.</p>\n</div>".gsub(/<(?:.|\n)*?>/, '')
      }),
      OpenStruct.new({
        asked_by: "Oscar O.",
        asked_on: "Sat, May 1, 2016",
        title: "Try out writing the skilltree biography?",
        content: "<div data-reactid=\".0.0.0.1.0.0.1.0.1.1.0\">\n<p>I noticed the \"Bio\" section of skilltree with different people using different approaches to write theirs, and I was wondering if there is a recommended format for it.</p>\n</div>".gsub(/<(?:.|\n)*?>/, '')
      })
    ]
  end
end