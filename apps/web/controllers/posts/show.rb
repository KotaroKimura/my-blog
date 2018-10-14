module Web::Controllers::Posts
  class Show
    include Web::Action

    expose :post
    accept :html, :json

    def initialize; end

    def call(params)
      if format == :json
        interactor = Blog::Interactor::Show.new(params).call

        if interactor.successful?
          @post = interactor.post
        else
          halt 400, "Bad Request!"
        end
      end
    end
  end
end
