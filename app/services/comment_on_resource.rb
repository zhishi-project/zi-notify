class CommentOnResource < AiBase
  def initialize(result)
    @request_data = result
    @url = set_url(result['parameters'])
  end

  def set_url(params)
    "#{params['resource']}/#{params['resource_id']}/comments"
  end

  def prepare_payload
    request_data['parameters']
  end

  def prepare_response(body)
    binding.pry
  end
end
