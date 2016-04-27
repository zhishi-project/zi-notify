class AnswerQuestion < AiBase
  def initialize(result)
    @request_data = result
    question_id = result['parameters']['id']
    @url = "questions/#{question_id}/answers"
  end

  def prepare_payload
    {
      'content' => request_data['parameters']['content']
    }
  end

  def prepare_response(body)
    binding.pry
  end
end
