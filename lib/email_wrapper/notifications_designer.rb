module EmailWrapper
  class NotificationsDesigner < BaseDesigner
    class << self
      def template
        File.read(Rails.root.join("lib/email_wrapper/templates/notifications/template.html.erb"))
      end
    end
  end
end