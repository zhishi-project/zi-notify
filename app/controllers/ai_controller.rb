class AiController < ApplicationController
  def index
    request_handler = AiBase.process_request(params)

    if request_handler
      render json: request_handler.complete_request
    else
      puts 'something is wrong'
    end
  end
end
