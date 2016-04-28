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

  def process_response(response)
    body = JSON.parse(response.body)
    return failed(body) if response.status > 300

    prepare_response(body)
  end

  def prepare_response(dummy)
    questions  = dummy["questions"]
    response = AiResponse.new
    if questions.empty?
      intent = "Ouch! I couldn't find questions matching your request criteria"
      response.add_pretext(intent)
      response.speech_and_displaytext(intent)
      response.title('Response')
      response.add_text('No question found')
    else
      questions[0...10].each do |q|
        response.add_field(q['title'], q['content'])
      end
      intent = 'Here are some questions I found'
      response.add_pretext(intent)
      response.speech_and_displaytext(intent)
    end
    response.package_response
  end
end
