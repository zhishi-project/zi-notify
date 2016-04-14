module ZhishiWrapper
  class Question < ZhishiWrapper::Base
    delegate :id, :title, :content, :tags, :url, :user, to: :payload
    include Concerns::ResourceSubscriber

    def user
      ZhishiWrapper::User.new(payload.user)
    end

    # def subscribers
    #   payload.subscribers.map do |user|
    #     ZhishiWrapper::User.new(user)
    #   end
    # end
  end
end
