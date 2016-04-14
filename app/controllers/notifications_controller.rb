class NotificationsController < ApplicationController
  def receive
    # receive JSON payload from Zhishi, resolve and send
    # subscribers = params[:subscribers]
    # message_body = params[:content]
    # users
    # types new.question, new.answer, new.comment

    notification_type = params['notification']['type']
    payload = Hashie::Mash.new(params['notification'])

    notification = case notification_type
    when 'new.question'
      ZhishiWrapper::Question.new(payload)
    when 'new.answer'
      ZhishiWrapper::Answer.new(payload)
    when 'new.comment'
      ZhishiWrapper::Comment.new(payload)
    end

    require 'pry' ; binding.pry

  end
end
