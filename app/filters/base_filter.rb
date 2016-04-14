class BaseFilter
  # NOTE the filters basically strips out unsupported tags that might not be useful on the platform
  attr_reader :message

  def initialize(message)
    @message = message
  end

  def cleaned
    message
  end
end
