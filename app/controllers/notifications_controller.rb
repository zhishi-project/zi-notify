class NotificationsController < ApplicationController
  def receive
    notification = ZhishiNotification.new(payload)
    if notification.zhishi_notification?
      resource = notification.presentable_resource
      [SlackService, EmailService, WebSocketService, SmsService].each do |service|
        service.new(resource).notify
      end
    end
  end

  def users_slack_info
    render json: { users: User.slack_info }
  end

  private
    def payload
      return @payload if @payload
      auth_header = request.headers['Authorization']
      _ , token = auth_header.split('=')
      @payload ||= TokenManager.authenticate(token)['payload']
    end
end
