module Admin
  module Controllers
    module Posts
      class Update
        include Admin::Action

        accept :json

        def initialize; end

        def call(params)
          halt 415, "Unsupported Format." unless format == :json
          interactor = ::Posts::UpdateOne.new(interacted_params(params)).call

          halt 500, interactor.errors.join(' / ') unless interactor.successful?
          self.body = 'Saved.'
        end

        private

        def interacted_params(params)
          JSON.parse(request.body.read).tap do |_b|
            _b['id'] = params[:id]
          end
        end
      end
    end
  end
end
