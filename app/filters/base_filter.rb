class BaseFilter
  # NOTE the filters basically strips out unsupported tags that might not be useful on the platform
  attr_reader :resource, :content
  # defined in lib/missing_delegator which basically adds a method_missing and respond to missing
  include MissingDelegator

  def delegated_to
    resource
  end

  def initialize(content:, resource: nil)
    @content = content
    @resource = resource
  end

  def cleaned
    ERB.new(content).result(binding)
  end

  def root_url
    ENV['ZHISHI_URL']
  end

  def sanitize_content
    content.gsub(/<(?:.|\n)*?>/, '')
  end
end
