require 'hanami/interactor'
require 'hanami/validations'

module Images
  class CreateOne
    include Hanami::Interactor
    include ::Blog::Interactors::Concerns::Validatable

    Validation.class_eval do
      validations do
        required(:filename) { filled? & str? }
        required(:tempfile) { filled? & type?(Tempfile) }
        required(:post_id)  { filled? & str? & format?(/\A[0-9]+\z/) }
      end
    end

    expose :image

    def initialize(params)
      @params = {
        filename: params[:image][:filename],
        tempfile: params[:image][:tempfile],
        post_id:  params[:post_id]
      }
    end

    def call
      entity = Image.new(post_id: @params[:post_id], name: @params[:filename], image: File.open(@params[:tempfile]))
      @image = ImageRepository.new.create(entity)

      if @image.nil?
        error("Could Not Save.")
        nil
      end
    end
  end
end