require 'hanami/interactor'
require 'hanami/validations'

module Posts
  class GetOne
    class Validation
      include Hanami::Validations

      validations do
        required(:id) { filled? & str? & format?(/\A[0-9]+\z/) }
      end
    end

    include Hanami::Interactor

    expose :post
    expose :images

    def initialize(params)
      @params = params
    end

    def call
      @post = PostRepository.new.find_with_images(@params[:id])
    end

    private

    def valid?
      @validate_result = Validation.new(@params).validate
      @validate_result.success?
    end
  end
end