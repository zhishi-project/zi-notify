module ZhishiWrapper
  class Answer < ZhishiWrapper::Base
    delegate :id, :content, :url, :user, :question, to: :payload

    def user
      ZhishiWrapper::User.new(payload.user)
    end

  end
end
