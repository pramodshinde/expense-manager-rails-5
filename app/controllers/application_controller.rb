class ApplicationController < ActionController::API
  before_action :authenticate!
  
  include ActionController::Serialization
  X_API_KEY = 'X-Api-Key'

  private 

  def authenticate!
    set_current_user || render_unauthorized
  end
  
  def set_current_user
    return false unless api_key?
    claims = ApiKeyHandler.decode_api_key(request.headers[X_API_KEY])
    @current_user = User.find(claims[0]['user_id'])
  rescue JWT::ExpiredSignature
    render_expired_message
  rescue JWT::DecodeError
    render_decode_error
  end

  def api_key?
    request.headers[X_API_KEY].present?
  end

  def render_expired_message
    render_message(message: "Api key is expired", info: "Please obtain new api key", status: 401)
  end

  def render_unauthorized
    render_message(
      message: "No Authorization key in header", 
      info: "Api key is not provided", 
      status: 401
    )
  end

  def render_decode_error
    render_message(
      message: "Invalid API key", 
      info: "Obtain Api key by login api", 
      status: 401
    )
  end
  
  def render_message(message:, info: nil, status: 200)
    response_hash = {}
    response_hash[:message] = message
    response_hash[:info] = info if info
    render json: response_hash, status: status 
  end
end

