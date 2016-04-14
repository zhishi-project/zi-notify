class SlackService < BaseNotificationService

  def notify
    SlackWrapper::Client.send_message()
  end
end
