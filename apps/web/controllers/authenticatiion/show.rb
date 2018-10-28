module Web::Controllers::Authentication
  class Show
    include Web::Action

    expose :api_token
    accept :json

    def initialize; end

    def call(params)
      session[:api_token] ||= SecureRandom.hex(32)
      @api_token = session[:api_token]
    end
  end
end
