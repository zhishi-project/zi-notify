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

  def attachment_option_for_user(user, resource, platform)
    if resource.mentionable? && resource.mentioned_users.include?(user)
      resource.send("to_#{platform}_attachment", mention: true)
    else
      resource.send("to_#{platform}_attachment")
    end
  end
end
