module ZhishiWrapper
  class Answer < ZhishiWrapper::Base
    delegate :id, :content, :url, to: :payload
    include Concerns::ResourceOwner
    include Concerns::ResourceSubscriber

    def question
      @question =|| ZhishiWrapper::Question.new(payload.question)
    end
  end
end
