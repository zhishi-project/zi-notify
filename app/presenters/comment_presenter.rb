class CommentPresenter < BasePresenter
  attr_reader :resource
  delegate :url, :content, :user, :subscribers, :question, to: :resource

  def fallback
    question.title
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

  def to_slack_attachment(mention: false)
    pretext = mention ? mention_pretext : normal_pretext
    filtered = slack_transform(pretext)
    sanitized_content = strip_html_tags(content)
    [
      {
        fallback: fallback,
        pretext: filtered,
        color: 'good',
        title_link: url,
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
end
