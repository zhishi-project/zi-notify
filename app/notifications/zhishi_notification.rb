class ZhishiNotification
  ZHISHI_EVENTS = /new\.(?<type>question|user|answer|comment)/
  attr_reader :resource, :wrapper_type

  def initialize(payload)
    @wrapper_type = payload['notification']['type']
    @resource =  Hashie::Mash.new(payload['notification'])
  end

  def match_notification_type
    @match ||= ZHISHI_EVENTS.match(wrapper_type)
  end

  def zhishi_notification?
    match_notification_type
  end

  def resource_type
    match_notification_type[:type].capitalize
  end

  def type
    "ZhishiWrapper::#{resource_type}".constantize
  end

  def deserialized_notification
    type.new(resource)
  end

  def presenter
    "#{resource_type}Presenter".constantize
  end

  def presentable_resource
    @presentable ||= presenter.new(deserialized_notification)
  end
end
