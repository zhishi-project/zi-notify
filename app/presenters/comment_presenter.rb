class CommentPresenter < BasePresenter
  attr_reader :resource
  delegate :content, :user, :subscribers, :question, to: :resource

  def fallback
    question.title
  end

  def url
    question.url
  end

  def parent
    resource.parent.type
  end

  def normal_pretext
    "Hey, <%= user_url user %> just commented on your #{on} on <%= link_to 'Zhishi', root_url %>: #{question.title}"
  end

  def normal_pretext_email
    "Hey, <%= user_url user %> just commented on your #{on}"
  end

  def mention_pretext
    "Hey, <%= user_url user %> just mentioned you in a comment"
  end

  def normal_subject
    "New Comment on Question"
  end

  def mention_subject
    "New Mention in Comment"
  end

  def to_slack_attachment(mention: false)
    pretext = mention ? mention_pretext : normal_pretext
    filtered = slack_transform(pretext)
    sanitized_content = strip_html_tags(content)
    [
      {
        fallback: fallback,
        pretext: filtered,
        color: 'good',
        title_link: tracked_url,
        title: question.title,
        text: sanitized_content,
        fields: [
          {
            title: 'Comment By',
            value: user.zhishi_name,
            short: true
          },
          {
            title: 'Tags',
            value: question.tags.try(:join, ', '),
            short: true
          }
        ]
      }
    ]
  end

  def to_email_attachment(mention: false)
    mail_params = {}
    mail_params[:subject] = mention ? mention_subject : normal_subject
    mail_pretext = mention ? mention_pretext : normal_pretext_email
    filtered_pretext = email_transform(mail_pretext)
    filtered_title = email_transform(question.title)
    sanitized_content = strip_html_tags(content).first(300) << "..."

    notification_data = {
      resource_link: url,
      resource_type: "Comment",
      notification_pretext: filtered_pretext,
      notification_title: filtered_title,
      notification_content: sanitized_content
    }
    mail_params[:body] = EmailWrapper::NotificationsDesigner.format_content(notification_data)

    mail_params
  end
end
