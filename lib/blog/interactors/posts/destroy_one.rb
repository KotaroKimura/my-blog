require 'hanami/interactor'
require 'hanami/validations'

module Posts
  class DestroyOne
    include Hanami::Interactor
    include ::Blog::Interactors::Concerns::Validatable

    Validation.class_eval do
      validations do
        required(:id) { filled? & str? & format?(/\A[0-9]+\z/) }
      end
    end

    def initialize(params)
      @params = params
    end

    def call
      post = PostRepository.new.delete(@params[:id])

      if post.nil?
        error("Could Not Delete.")
        nil
      end
    end
  end
end