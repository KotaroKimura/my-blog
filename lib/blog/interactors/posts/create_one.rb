require 'hanami/interactor'

module Posts
  class CreateOne
    include Hanami::Interactor

    expose :post

    def initialize(params)
      @params = params
    end

    def call
      @post = PostRepository.new.create(title: 'タイトルを入力してください.', body: '本文を入力してください.', published_date:  Date.today)

      if @post.nil?
        error("Could Not Save.")
        nil
      end
    end
  end
end