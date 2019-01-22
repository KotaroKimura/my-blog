module Web::Controllers::Posts
  module Concerns
    module TokenEmitable

      def set_api_toke
        session[:api_token] ||= SecureRandom.hex(32)
        @api_token = session[:api_token]
      end

    end
  end
end