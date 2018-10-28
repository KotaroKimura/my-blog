module Web::Controllers::Posts
  class Show
    include Web::Action

    expose :post
    accept :html, :json

    def initialize; end

    def call(params)
      if format == :json
        return halt 401, "Unauthorized!" unless session[:api_token] == params.env["HTTP_BACKEND_API_TOKEN"]
        interactor = Posts::Show.new(params).call

        if interactor.successful?
          @post = interactor.post
        else
          halt 400, "Bad Request!"
        end
      end
    end
  end
end
