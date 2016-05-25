class AiBase
  include ZhishiConn
  attr_reader :request_data, :url

  def self.process_request(payload)
    result = payload[:result]
    result[:action].camelize.constantize.new(result) if
      result && result[:actionIncomplete] == 'false'
  end

  def get_user
    contexts = request_data['contexts'].find{|data| data['parameters']['slack_user_id'] }
    slack_info = contexts["parameters"]
    user_slack_id = slack_info["slack_user_id"]
    User.find_by(slack_id: user_slack_id)
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
    return failed(body) if response.status >= 300

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
    payload = get_user.try(:zhishi_id)
    TokenManager.generate_token(payload)
  end
end
