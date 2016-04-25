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
    "Hey, <%= user_url user %> just commented on your #{on} on <%= link_to root_url, 'Zhishi'%>: #{question.title}"
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
    mail_body = mention ? mention_pretext : normal_pretext
    filtered_body = email_transform(mail_body)
    asked_by = "Comment By: #{user.zhishi_name}"

    notification_data = {
      resource_link: url,
      resource_type: "Comment",
      notification_content: [filtered_body, content, asked_by].join("<br /><br />")
    }
    mail_params[:body] = EmailWrapper::Designer.format_content(notification_data)

    mail_params
  end
end
