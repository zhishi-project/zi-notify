class UserPresenter < BasePresenter
  def mentionable?
    false
  end

  def subscribed_users
    # [user]
    subscribers
  end
end
