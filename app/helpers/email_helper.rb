module EmailHelper
  include Rails.application.routes.url_helpers
  include ActionView::Helpers::UrlHelper
  include BaseHelper

  def user_url(user)
    link_to user.zhishi_name, "#{ENV['ZHISHI_URL']}/users/#{user.zhishi_id}-#{user.zhishi_name.gsub(' ', '-')}"
  end
end
