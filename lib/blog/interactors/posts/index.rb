require 'hanami/interactor'
require 'hanami/validations'

module Posts
  class Index
    class Validation
      include Hanami::Validations

      validations do; end
    end

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

    private

    def valid?
      @validate_result = Validation.new(@params).validate
      @validate_result.success?
    end
  end
end