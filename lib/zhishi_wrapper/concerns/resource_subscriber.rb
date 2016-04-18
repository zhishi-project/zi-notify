module ZhishiWrapper
  module Concerns
    module ResourceSubscriber
      def payload_subscribers
        payload.fetch('subscribers', [])
      end
      
      def subscribers
        @subscribers ||= payload_subscribers.map do |user|
          ZhishiWrapper::User.new(user).local_user
        end
      end

      def subscribers_by_id
        collection = payload_subscribers.map(&:id)
        @subscribers ||= ::User.from_zhishi_collection(collection)
      end
    end
  end
end
