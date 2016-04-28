class AskQuestion < AiBase
  def initialize(result)
    @request_data = result
    @url = '/questions'
    @intent = 'asked your question'
  end

  def prepare_payload
    request_data[:parameters]
  end

  def prepare_response(dummy, response)
    response.set_title(dummy.title, dummy.url)
    response.add_text(dummy.content)
    response.add_field('Tags', dummy.tags.join(', '))
    response.package_response
  end
end
