class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods
  before_action :authenticate_request

  private
  def authenticate_request
    authenticate_token || unauthorized_token
  end

  def authenticate_token
    authenticate_with_http_token do |auth_token, _|
    @payload = TokenManager.authenticate(auth_token)['payload']
    end
  end

  def unauthorized_token
    self.headers['WWW-Authenticate'] = 'Token realm="Application"'
    render json: {errors: "Request was made with invalid token"}, status: 401
  end
end
