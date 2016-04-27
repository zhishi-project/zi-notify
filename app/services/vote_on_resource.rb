class VoteOnResource < AiBase
  def initialize(result)
    @request_data = result
    @url = set_url(result['parameters'])
  end

  def set_url(params)
    "#{params['resource']}/#{params['resource_id']}/#{params['vote']}"
  end

  def prepare_response(body)
    # TODO: 
  end
end
