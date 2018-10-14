require 'hanami/interactor'
require 'hanami/validations'

module Blog::Interactor
  class Show
    class Validation
      include Hanami::Validations

      validations do
        required(:id).value(:filled?, format?: /\A[0-9]+\z/)
      end
    end

    include Hanami::Interactor

    expose :post

    def initialize(params)
      @params = params
    end

    def call
      @post = PostRepository.new.find(@params[:id])
    end

    private

    def valid?
      @validate_result = Validation.new(@params).validate
      @validate_result.success?
    end
  end
end