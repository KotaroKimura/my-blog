module Admin
  module Controllers
    module Images
      class Create
        include Admin::Action

        accept :json
        expose :_image

        def call(params)
          halt 415, "Unsupported Format." unless format == :json
          interactor = ::Images::CreateOne.new(params).call

          halt 500, interactor.error unless interactor.successful?
          @_image = interactor.image
        end
      end
    end
  end
end
