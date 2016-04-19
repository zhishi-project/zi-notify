module ZhishiWrapper
  class Comment < ZhishiWrapper::Base
    delegate :id, :content, :url , to: :payload
    include Concerns::ResourceOwner
    include Concerns::ResourceSubscriber

    def on_answer?
      on == 'Answer'
    end

    def on_question?
      on == 'Question'
    end

    def question
      @question ||= if on_answer?
        ZhishiWrapper::Answer.new(payload.parent)
      elsif on_question?
        ZhishiWrapper::Question.new(payload.parent)
      end
    end

    def on
      payload.parent.type
    end
  end
end
