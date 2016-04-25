class BaseNotificationService
  attr_reader :resource

  def initialize(resource)
    @resource = resource
  end

  def subscribers
    resource.subscribed_users
  end

  def notify
    subscribers.each do |user|
      user.send_message(resource, service: self)
    end
  end
end
