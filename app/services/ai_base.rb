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
    return failed(response) if response.status > 300
    prepare_response(JSON.parse(response.body))
  end

  def set_header
    {
      'Authorization' => "Token token=#{get_token}",
      'Content-type' => 'application/json'
    }
  end

  def failed(response)
    JSON.parse(response.body)
  end

  def get_token
    # get user
  end
end
