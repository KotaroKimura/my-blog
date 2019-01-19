module Admin
  module Controllers
    module Posts
      class Destroy
        include Admin::Action

        accept :html

        def call(params)
          halt 415, "Unsupported Format." unless format == :html
          interactor = ::Posts::DestroyOne.new(params).call

          flash[:error] = 'Could Not Remove Post. Please Try Again.' unless interactor.successful?
          redirect_to routes.posts_path
        end
      end
    end
  end
end
