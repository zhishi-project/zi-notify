class AskQuestion < AiBase
  def initialize(result)
    @request_data = result
    @url = '/questions'
  end

  def prepare_payload
    request_data[:parameters]
  end

  def prepare_response(dummy)
    presenter = QuestionPresenter.new(dummy)
    {
      "speech": "Done! Your question *#{dummy.title}* has been added to Zhishi knowledge base :thumbsup:",
      "displayText": "Done! Your question *#{dummy.title}* has been added to Zhishi knowledge base :thumbsup:",
      "data": presenter.to_slack_attachment
    }
  end
end
