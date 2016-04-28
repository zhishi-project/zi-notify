class AiBase
  include ZhishiConn

  def self.process_request(payload)
    result = payload[:result]
    return if !result || result[:actionIncomplete] == 'true'
    result[:action].camelize.constantize.new(result)
  end

  attr_reader :request_data, :url

  def user
  end

  def complete_request
    package = try(:prepare_payload)
    response = send_to_zhishi(package)
    process_response(response)
  end

  def send_to_zhishi(package)
    header = set_header
    zhishi_conn.post do |conn|
      conn.headers = header
      conn.body = package.to_json if package
      conn.url(url)
    end
  end

  def process_response(response)
    body = JSON.parse(response.body)
    return failed(body) if response.status > 300

    dummy = DummyObject.setup(body)
    response = AiResponse.new

    intent = "Nice, I #{@intent} successfully. Here, check it out."
    response.add_pretext(intent)
    response.speech_and_displaytext(intent)
    prepare_response(dummy, response)
  end

  def set_header
    {
      'Authorization' => "Token token=#{get_token}",
      'Content-type' => 'application/json'
    }
  end

  def failed(body)
    err = "Something went wrong and I couldn't complete your request"
    title, message = body.first
    response = AiResponse.new("#FF0000")
    response.add_pretext(err)
    response.speech_and_displaytext(err)
    response.set_title(title)
    response.add_text(message)
    response.package_response
  end

  def get_token
    # get user
  end
end
