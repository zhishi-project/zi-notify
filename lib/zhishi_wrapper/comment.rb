module ZhishiWrapper
  class Comment < ZhishiWrapper::Base
    delegate :id, :content, :url, :user, to: :payload
    include Concerns::ResourceSubscriber

    def user
      ZhishiWrapper::User.new(payload.user)
    end

  end
end
