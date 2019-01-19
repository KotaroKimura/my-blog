module Admin
  module Controllers
    module Posts
      class Create
        include Admin::Action

        accept :json

        def call(params)
          halt 415, "Unsupported Format." unless format == :json
          interactor = ::Posts::CreateOne.new(params).call

          halt 500, interactor.error unless interactor.successful?
          self.body = routes.edit_post_path(interactor.post.id)
        end
      end
    end
  end
end
