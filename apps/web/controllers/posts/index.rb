module Web::Controllers::Posts
  class Index
    include Web::Action
    include Concerns::TokenEmitable

    before :set_api_toke

    expose :posts, :api_token
    accept :html, :json

    def initialize; end

    def call(params)
      if format == :json
        return halt 401, "Unauthorized!" unless session[:api_token] == params.env["HTTP_BACKEND_API_TOKEN"]
        interactor = Posts::GetList.new(params).call

        if interactor.successful?
          @posts = interactor.posts
        else
          halt 400, "Bad Request!"
        end
      end
    end
  end
end
