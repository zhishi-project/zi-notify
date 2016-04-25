class AnswerPresenter < BasePresenter
  attr_reader :resource
  delegate :content, :user, :subscribers, :question, to: :resource

  def fallback
    question.title
  end

  def url
    question.url
  end

  def normal_pretext
    "Hey, <%= user_url user %> just answered your question on <%= link_to root_url, 'Zhishi' %>: #{question.title}"
  end

  def normal_subject
    "New Answer on Question"
  end

  def mention_subject
    "New Mention in Answer"
  end

  def mention_pretext
    "Hey, <%= user_url user %> just mentioned you in an answer"
  end

  def to_slack_attachment(mention: false)
    pretext = mention ? mention_pretext : normal_pretext
    filtered = slack_transform(pretext)
    [
      {
        fallback: fallback,
        pretext: filtered,
        color: 'good',
        title_link: tracked_url,
        title: question.title,
        text: content,
        fields: [
          {
            title: 'Answered By',
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
