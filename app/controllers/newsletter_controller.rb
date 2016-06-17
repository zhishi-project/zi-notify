class NewsletterController < ApplicationController
  def receive
    mail_questions = []
    questions.each { |question| mail_questions << question }

    newsletter = {}
    newsletter[:mail_questions] = mail_questions
    newsletter[:zhishi_url] = ENV["ZHISHI_URL"]
    send_mail(newsletter)
  end

  def send_mail(newsletter)
    mail_params = {}
    mail_params[:subject] = "Zhishi Weekly Newsletter"
    mail_params[:body] = EmailWrapper::NewsletterDesigner.format_content(newsletter)  
    
    newsletter_emails.each do |email|
      NewsletterMailer.notify_by_mail(mail_params, to: email).deliver
    end
  end

  def newsletter_emails
    user_emails = []
    User.where.not(zhishi_id: nil).each do |user| 
      user_emails << user.email if user.preference.try(:newsletter)
    end

    user_emails
  end

  def questions
    [
      OpenStruct.new({
        asked_by: "Seyi Adekoya",
        image: "https://lh3.googleusercontent.com/-TmaBMhYx8mU/AAAAAAAAAAI/AAAAAAAAABg/clWfb3kLxZc/photo.jpg",
        title: "Where can I study JavaScript source code",
        content: "<p>If I want to view Ruby's source code I can go to <a href=\"http://github.com/ruby/ruby\">http://github.com/ruby/ruby</a>&nbsp;but for JavaScript there seems to be nothing like that.</p>".gsub(/<(?:.|\n)*?>/, ''),
        url: "https://zhishi.andela.com/questions/102",
        user_url: "https://zhishi.andela.com/users/90-"
      }),
      OpenStruct.new({
        asked_by: "Amodu Temitope",
        image: "https://lh6.googleusercontent.com/-0FvJsatjem8/AAAAAAAAAAI/AAAAAAAAAA0/4M9yUeAGheA/photo.jpg",
        title: "Is there a recommended format for writing the skilltree biography?",
        content: "<div data-reactid=\".0.0.1.0.0.0.1.0.0.1.0.1.1.0\">\n<div data-reactid=\".0.0.0.1.0.0.1.0.1.1.0\">\n<p>I noticed the \"Bio\" section of skilltree with different people using different approaches to write theirs, and I was wondering if there is a recommended format for it.</p>\n</div>\n</div>".gsub(/<(?:.|\n)*?>/, ''),
        url: "https://zhishi.andela.com/questions/37",
        user_url: "https://zhishi.andela.com/users/32-"
      }),
      OpenStruct.new({
        asked_by: "Adebayo Adepoju",
        image: "https://lh5.googleusercontent.com/-P0_NF5qwOc0/AAAAAAAAAAI/AAAAAAAAADw/dP_D_ZTdRXw/photo.jpg",
        title: "Why is asking questions on Zhishi better than asking an individual on slack?",
        content: "<div data-reactid=\".0.0.1.0.0.0.1.0.0.1.0.1.1.0\">\n<p>I would like to know why we advise Andelans&nbsp;to use Zhishi instead&nbsp;of just reaching out to anyone on slack.</p>\n</div>".gsub(/<(?:.|\n)*?>/, ''),
        url: "https://zhishi.andela.com/questions/112",
        user_url: "https://zhishi.andela.com/users/5-"
      }),
      OpenStruct.new({
        asked_by: "Seyi Adekoya",
        image: "https://lh3.googleusercontent.com/-TmaBMhYx8mU/AAAAAAAAAAI/AAAAAAAAABg/clWfb3kLxZc/photo.jpg",
        title: "Is Andela still considered a startup?",
        content: "<p>Is Andela still considered a startup?</p>".gsub(/<(?:.|\n)*?>/, ''),
        url: "https://zhishi.andela.com/questions/100",
        user_url: "https://zhishi.andela.com/users/90-"
      }),
      OpenStruct.new({
        asked_by: "Amodu Temitope",
        image: "https://lh6.googleusercontent.com/-0FvJsatjem8/AAAAAAAAAAI/AAAAAAAAAA0/4M9yUeAGheA/photo.jpg",
        title: "Is it possible for you to have your leave request be rejected?",
        content: "<p>Is it possible to have your leave request rejected? If yes, what are the possible reasons for the rejection.&nbsp;</p>".gsub(/<(?:.|\n)*?>/, ''),
        url: "https://zhishi.andela.com/questions/63",
        user_url: "https://zhishi.andela.com/users/32-"
      })
    ]
  end
end