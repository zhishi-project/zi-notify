module MissingDelegator
  extend ActiveSupport::Concern
  included do
    prepend MissingDelegator
  end

  # attr_accessor :delegated_to

  def method_missing(method_name, *args, &block)
    if delegated_to.respond_to? method_name
      delegated_to.send(method_name, *args, &block)
    else
      super
    end
  end

  def respond_to_missing?(method_name, *)
    delegated_to.respond_to?(method_name) || super
  end
end
