class BasePresenter
  attr_reader :resource
  include MissingDelegator

  def delegated_to
    resource
  end

  def initialize(resource)
    @resource = resource
    setup
  end

  def setup
    # other setup logic would be coming here for presenters
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
  
  ['slack', 'email'].each do |platform|
    define_method "#{platform}_transform" do |text|
      "#{platform.capitalize}Filter".constantize.new(
          content: text,
          resource: resource
        ).cleaned
    end
  end

  def strip_html_tags(content)
    BaseFilter.new(content: content).sanitize_content
  end

  def tracked_url
    AnalyticsTrackingParams::UrlParams.append_tracking_params(url)
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
      resource_type: resource.class.to_s.demodulize,
      notification_pretext: filtered_pretext,
      notification_title: filtered_title,
      notification_content: sanitized_content
    }
    mail_params[:body] = EmailWrapper::NotificationsDesigner.format_content(notification_data)

    mail_params
  end
end
