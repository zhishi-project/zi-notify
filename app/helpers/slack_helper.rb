module SlackHelper
  include ::BaseHelper

  def link_to(path, text)
    "<#{path}|#{text}>"
  end

  def user_url(user)
    "<@#{user.slack_id}>"
  end
end
