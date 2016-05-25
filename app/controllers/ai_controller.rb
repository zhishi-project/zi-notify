class AiController < ApplicationController
  skip_before_action :authenticate_request
  def index
    request_handler = AiBase.process_request(params)

    if request_handler
      render json: request_handler.complete_request
    else
      puts 'something is wrong'
    end
  end
end
