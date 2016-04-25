module SlackWrapper
  module Client
    class << self
      def client
        @client ||= Slack::Web::Client.new
      end

      def find_slack_user(user)
        client.users_info(user: user)
      end

      def slack_user(user)
        user = find_slack_user(user).user
        SlackWrapper::User.new(user)
      end

      def user_channel_id(user)
        client.im_open(user: user).try(:channel).try(:id)
      end

      def post_message(user, *args)
        options = {
          channel: user.slack_id,
          as_user: true,
        }.merge(*args)
        client.chat_postMessage(options)
      end

      def all_users
        client.users_list.members.reduce([]) do |reducer, user|
          reducer << SlackWrapper::User.new(user) unless user.deleted || user.is_bot
          reducer
        end
      end
    end
  end
end
