require 'hanami/interactor'
require 'hanami/validations'

module Posts
  class UpdateOne
    include Hanami::Interactor
    include ::Blog::Interactors::Concerns::Validatable

    Validation.class_eval do
      validations do
        required(:id)               { filled? & str? & format?(/\A[0-9]+\z/) }
        required(:title)            { filled? & str? }
        required(:body)             { filled? & str? }
        required(:published_state)  { filled? & int? & included_in?([0, 1, 2]) }
        required(:published_date)   { filled? & str? & format?(/\A\d{4}-\d{1,2}-\d{1,2}\z/) }
      end
    end

    def initialize(params)
      @params = {
        id:              params['id'],
        title:           params['title'],
        body:            params['body'],
        published_state: params['publishedState']['selected'],
        published_date:  params['publishedDate']
      }
    end

    def call
      post = PostRepository.new.update(
        @params[:id],
        title:           @params[:title],
        body:            @params[:body],
        published_state: @params[:published_state],
        published_date:  @params[:published_date],
      )

      if post.nil?
        error("Could Not Save.")
        nil
      end
    end

  end
end