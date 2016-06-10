module EmailWrapper
  class BaseDesigner
    class << self
      def inserted_content(content)
        ERB.new(template).result(OpenStruct.new(content).instance_eval { binding })
      end

      def format_content(content)
        inserted_content(content)
      end
    end
  end
end