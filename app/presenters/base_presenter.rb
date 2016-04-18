class BasePresenter
  attr_reader :resource

  def initialize(resource)
    @resource = resource
  end

  def mentionable?
    # if it's a question, answer, or comment user can be mentioned otherwise no
    true
  end

  def mentioned_users
    @mentions ||= mentionable? ? MentionsAnalyzer.new(resource).find_users : []
  end

  def subscribed_users
    (subscribers | mentioned_users) - [user]
  end

  def root_url
    ENV['ZHISHI_URL']
  end

  def slack_transform(text)
    SlackFilter.new(content: text, resource: resource).cleaned
  end
end
