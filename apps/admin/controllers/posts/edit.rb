module Admin
  module Controllers
    module Posts
      class Edit
        include Admin::Action

        expose :post
        accept :html, :json

        def call(params)
          if format == :json
            interactor = ::Posts::GetOne.new(params).call

            if interactor.successful?
              @post = interactor.post
            else
              halt 400, "Bad Request!"
            end
          end
        end
      end
    end
  end
end
