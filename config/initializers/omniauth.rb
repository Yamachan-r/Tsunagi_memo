require "omniauth"
require "omniauth-line"

Rails.application.config.middleware.use OmniAuth::Builder do
  OmniAuth.config.allowed_request_methods = [ :post, :get ]
  require "omniauth/strategies/line"
  provider :line, ENV["LINE_CHANNEL_ID"], ENV["LINE_CHANNEL_SECRET"],
           {
              scope: "profile openid"
           }
end
