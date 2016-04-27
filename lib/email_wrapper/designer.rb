module EmailWrapper
  class Designer
    class << self

      def inserted_content(content)
        template_file = File.read(Rails.root.join("lib/email_wrapper/templates/template.htm.erb"))
        ERB.new(template_file).result(OpenStruct.new(content).instance_eval { binding })
      end

      def format_content(content)
        inserted_content(content)
      end
    end
  end
end