class AskQuestion < AiBase
  def initialize(result)
    @request_data = result
    @url = '/questions'
  end

  def prepare_payload
    request_data[:parameters]
  end

  def prepare_response(response)
    body = JSON.parse(response.body)
    {
      "speech": "Done! Your question *#{body['title']}* has been added to Zhishi knowledge base :thumbsup:",
      "displayText": "Done! Your question *#{body['title']}* has been added to Zhishi knowledge base :thumbsup:",
      "data": to_slack_attachment(body)
    }
  end

  def to_slack_attachment(pack)
       [
         {
           fallback: pack['title'],
           color: 'good',
           title_link: pack['url'],
           title: pack['title'],
           text: pack['content'],
           fields: [
             {
               title: 'Tags',
               value: pack['tags'].try(:join, ', '),
               short: true
             }
           ]
         }
       ]
     end
end
