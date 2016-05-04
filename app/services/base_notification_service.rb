class BaseNotificationService
  attr_reader :base_resource

  def initialize(resource)
    @base_resource = resource
  end

  def subscribers
    base_resource.subscribed_users
  end

  def notify
    subscribers.each do |user|
      user.send_message(base_resource, service: self)
    end
  end
end
