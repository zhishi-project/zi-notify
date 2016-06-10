module EmailHelper
  include Rails.application.routes.url_helpers
  include ActionView::Helpers::UrlHelper

  def user_url(user)
    link_to "#{ENV['ZHISHi_URL']}/users/#{user.zhishi_id}", user.zhishi_name
  end
end
