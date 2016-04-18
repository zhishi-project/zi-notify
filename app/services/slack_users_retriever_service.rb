module SlackUsersRetrieverService
  def self.retrieve
    slack_users = SlackWrapper::Client.all_users
    slack_users.map do |user|
      User.from_slack(user)
    end
  end
end
