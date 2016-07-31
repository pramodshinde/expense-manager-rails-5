class ApiKeyHandler

  def self.encoded_api_key(user_id)
    payload = { exp: 4.week.from_now.to_i, user_id: user_id.to_s }
    api_key = JWT.encode(payload, Rails.application.secrets.secret_key_base)
  end

  def self.decode_api_key(api_key)
    ## Sample claims hash 
    # [
    #  {
    #   "exp"=>1443275296, 
    #   "user_id"=>"55e1b72e84f16d427a000000"
    #  }, 
    #  {"typ"=>"JWT", "alg"=>"HS256"}]
    JWT.decode(api_key, Rails.application.secrets.secret_key_base)
  end
end
