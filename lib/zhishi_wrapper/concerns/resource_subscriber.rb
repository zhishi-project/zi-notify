module ZhishiWrapper
  module Concerns
    module ResourceSubscriber
      # extend
      def subscribers
        collection = payload.subscribers.map(&:id)
        ::User.from_zhishi_collection(collection)
        # payload.subscribers.map do |user|
        #   ZhishiWrapper::User.new(user)
        # end
      end
    end
  end
end
