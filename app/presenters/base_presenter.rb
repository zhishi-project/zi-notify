class BasePresenter
  attr_reader :resource
  include MissingDelegator

  def delegated_to
    resource
  end

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

  def strip_html_tags(content)
    BaseFilter.new(content: content).sanitize_content
  end

  def url
    AnalyticsTrackingParams::UrlParams.append_tracking_params(resource.url)
  end
end
