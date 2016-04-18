class BaseFilter
  # NOTE the filters basically strips out unsupported tags that might not be useful on the platform
  attr_reader :resource, :content

  def initialize(content:, resource: nil)
    @content = content
    @resource = resource
  end

  def cleaned
    content.gsub(/{{{!#(.+?)}}}/) do |match|
      instance_eval($1)
    end
  end

  def method_missing(method_name, *args, &block)
    if resource.respond_to? method_name
      resource.send(method_name, *args, &block)
    else
      super
    end
  end

  def respond_to_missing?(method_name, *)
    resource.respond_to?(method_name) || super
  end

  def root_url
    ENV['ZHISHI_URL']
  end

  def sanitize_content(content)
    content
  end
end
