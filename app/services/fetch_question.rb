class FetchQuestion < AiBase
  def initialize(result)
    @request_data = result
    set_url(result["parameters"]["question_type"])
  end

  def set_url(question_type)
    @url = (question_type == 'top') ? '/top_questions' : '/questions'
  end

  def send_to_zhishi(package)
    header = set_header
    zhishi_conn.get do |conn|
      conn.headers = header
      conn.url(url)
    end
  end

  def prepare_response(body)
    {
      'speech' => 'Successful',
      'displayText' => 'Do you want to do that again',
      'data' => body
    }
  end
end
