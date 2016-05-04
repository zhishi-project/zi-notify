class SlackService < BaseNotificationService
  def client
    SlackWrapper::Client
  end

  def inform(user, resource: base_resource)
    unless user.slack_id.nil?
      attachment_option = attachment_option_for_user(user, resource)
      client.post_message(user, attachments: attachment_option)
    end
  end

  def attachment_option_for_user(user, resource)
    if resource.mentionable? && resource.mentioned_users.include?(user)
      resource.to_slack_attachment(mention: true)
    else
      resource.to_slack_attachment
    end
  end
end
