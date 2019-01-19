require 'hanami/interactor'
require 'hanami/validations'

module Images
  class DestroyOne
    include Hanami::Interactor
    include Concerns::Validatable

    Validation.class_eval do
      validations do
        required(:name)    { filled? & str? }
        required(:miniurl) { filled? & str? }
      end
    end

    def initialize(params)
      @params = params
    end

    def call
      images = get_destroyed_image @params[:name], @params[:miniurl]
      unless images.size == 1
        error('There Are Multiple Images.')
        return nil
      end

      image = ImageRepository.new.delete(images[0][:id])

      if image.nil?
        error('Could Not Destroy.')
        nil
      end
    end

    private

    def get_destroyed_image name, data
      images = ImageRepository.new.images.where(name: name).map do |image|
        if data.include?(JSON.parse(image[:image_data])['id'])
          image
        end
      end.compact
    end
  end
end