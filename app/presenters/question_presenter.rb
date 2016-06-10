class QuestionPresenter < BasePresenter
  delegate :id, :url, :title, :content, :user, :tags, :subscribers, to: :resource

  def fallback
    title
  end

  def normal_pretext
    "Hey, <%= user_url user %> just asked a question which you might be in the best position to answer"
  end

  def mention_pretext
    "Hey, <%= user_url user %> just mentioned you in a question"
  end

  def remake_message
    "<%= link_to url, title %>\n#{content}"
  end

  def mention_subject
    "New Mention in Question"
  end

  def normal_subject
    "New Question in Subscribed Category"
  end

  def title_text
    "<%= question_tag id %> #{title}"
  end

  def action_message
    "You can include <%= answer_tag id %> or <%= comment_tag id %> in your message to answer or comment on the question respectively.\nReact with :+1: to upvote or :-1: to downvote this question.\nYou can also send <%= upvote_tag id %> or <%= downvote_tag id %>"
  end



  def to_slack_attachment(mention: false)
    pretext = mention ? mention_pretext : normal_pretext
    filtered = slack_transform(pretext)
    title_text_content = slack_transform(title_text)
    action_message_text = slack_transform(action_message)
    sanitized_content = strip_html_tags(content)
    [
      {
        fallback: fallback,
        pretext: filtered,
        color: 'good',
        title: title_text_content,
        title_link: tracked_url,
        fields: [
          {
            value: sanitized_content.first(100),
            short: false
          },
          {
            title: 'Asked By',
            value: user.zhishi_name,
            short: true
          },
          {
            title: 'Tags',
            value: tags.try(:join, ', '),
            short: true
          },
          # {
          #   value: action_message_text,
          #   short: false
          # }
        ]
      }
    ]
  end

  def to_email_attachment(mention: false)
    mail_params = {}
    mail_params[:subject] = mention ? mention_subject : normal_subject
    mail_pretext = mention ? mention_pretext : normal_pretext
    filtered_pretext = email_transform(mail_pretext)
    filtered_title = email_transform(title_text)
    sanitized_content = strip_html_tags(content).first(300) << "..."

    notification_data = {
      resource_link: url,
      resource_type: "Question",
      notification_pretext: filtered_pretext,
      notification_title: filtered_title,
      notification_content: sanitized_content
    }
    mail_params[:body] = EmailWrapper::NotificationsDesigner.format_content(notification_data)

    mail_params
  end
end
