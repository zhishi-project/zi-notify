class DummyObject
  def self.setup(package)
    package.each do |key, value|
      define_method "#{key}" do
        if value.kind_of? Hash
          DummyObject.setup(value)
        else
          value
        end
      end
    end
    new
  end
end
