module EmailWrapper
  class NewsletterDesigner < BaseDesigner
    class << self
      def template
        File.read(Rails.root.join("lib/email_wrapper/templates/newsletter/template.html.erb"))
      end
    end
  end
end