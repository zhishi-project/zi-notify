module ZhishiWrapper
  class Comment < ZhishiWrapper::Base
    delegate :id, :content, :url , to: :payload
    include Concerns::ResourceOwner
    include Concerns::ResourceSubscriber

    def on

    end

    def question
      if on_answer?

      elsif on_question?

      end
    end
  end
end
