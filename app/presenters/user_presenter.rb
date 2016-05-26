class UserPresenter < BasePresenter
  def mentionable?
    false
  end

  def setup
    user #local_user is a convenient way to check if user exists or create the user
  end

  def user
    resource.local_user
  end

  def subscribed_users
    [user]
  end
end
