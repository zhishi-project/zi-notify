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
      if check_service_allowed(user)
        user.send_message(resource, service: self)
      end
    end
  end

  def check_service_allowed(user)
    class_name = self.class.to_s
    check_preference(user, class_name)
  end

  def check_preference(user, class_name)
    service_name = class_name.sub("Service", "").downcase.to_sym
    user.preference.try(service_name)
  end
end
