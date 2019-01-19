module Admin
  module Controllers
    module Images
      class Destroy
        include Admin::Action

        accept :json

        def call(params)
          halt 415, "Unsupported Format." unless format == :json
          interactor = ::Images::DestroyOne.new(params).call

          halt 500, interactor.errors.join(' / ') unless interactor.successful?
          self.body = 'Deleted.'
        end
      end
    end
  end
end
