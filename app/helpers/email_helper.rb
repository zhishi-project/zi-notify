module EmailHelper
  include Rails.application.routes.url_helpers
  include ActionView::Helpers::UrlHelper

  def user_url(user)
    link_to user.zhishi_name, "#{ENV['ZHISHi_URL']}/users/#{user.zhishi_id}"
  end
end
