class BaseNotificationService
  attr_reader :message, :users

  def initialize(message)
    @message = message
    @users = users
  end
end
