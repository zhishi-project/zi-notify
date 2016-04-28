class AnswerQuestion < AiBase
  def initialize(result)
    @request_data = result
    question_id = result['parameters']['id']
    @url = "questions/#{question_id}/answers"
    @intent = "posted your answer"
  end

  def prepare_payload
    {
      'content' => request_data['parameters']['content']
    }
  end

  def prepare_response(dummy, response)
    response.add_text(dummy.content)
    response.package_response
  end
end
