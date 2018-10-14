module Web::Controllers::Posts
  class Index
    include Web::Action

    expose :posts
    accept :html, :json

    def initialize; end

    def call(params)
      if format == :json
        interactor = Blog::Interactor::Index.new(params).call

        if interactor.successful?
          @posts = interactor.posts
        else
          halt 400, "Bad Request!"
        end
      end
    end
  end
end
