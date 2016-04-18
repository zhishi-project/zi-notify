class NotificationsController < ApplicationController
  def receive
    notification = ZhishiNotification.new(params)
    if notification.zhishi_notification?
      resource = notification.presentable_resource
      require 'pry' ; binding.pry
      [SlackService, EmailService, WebSocketService, SmsService].each do |service|
        service.new(resource).notify
      end
    end
  end
end
