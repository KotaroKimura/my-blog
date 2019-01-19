require 'hanami/interactor'
require 'hanami/validations'

module Posts
  class UpdateOne
    include Hanami::Interactor
    include Concerns::Validatable

    Validation.class_eval do
      validations do
        required('id')    { filled? & str? & format?(/\A[0-9]+\z/) }
        required('title') { filled? & str? }
        required('body')  { filled? & str? }
      end
    end

    def initialize(params)
      @params = params
    end

    def call
      post = PostRepository.new.update(@params['id'], title: @params['title'], body: @params['body'])

      if post.nil?
        error("Could Not Save.")
        nil
      end
    end

  end
end