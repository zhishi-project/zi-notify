class SlackService < BaseNotificationService
  def client
    SlackWrapper::Client.client
  end

  def inform(user, resource: resource)
    if user.slack_id
      attachment_option = attachment_option_for_user(user, resource)
      client.chat_postMessage(attachments: attachment_option, channel: user.slack_id, as_user: true)
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
