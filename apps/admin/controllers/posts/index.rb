module Admin
  module Controllers
    module Posts
      class Index
        include Admin::Action

        expose :posts
        accept :html

        def call(params)
          @posts = PostRepository.new.all
        end
      end
    end
  end
end
