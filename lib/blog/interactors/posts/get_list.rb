require 'hanami/interactor'

module Posts
  class GetList
    include Hanami::Interactor

    expose :posts

    def initialize(params)
      @params = params
    end

    def call
      per_page = @params[:perPage].to_i
      offset   = (@params[:page].to_i - 1) * per_page
      @posts   = PostRepository.new.paginate_by(offset: offset, limit: per_page)
    end
  end
end