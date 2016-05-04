class NotificationsController < ApplicationController
  def receive
    notification = ZhishiNotification.new(params)
    if notification.zhishi_notification?
      resource = notification.presentable_resource
      [SlackService].each do |service|
        # , EmailService, WebSocketService, SmsService
        service.new(resource).notify
      end
    end
  end
end
