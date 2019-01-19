class ImageRepository < Hanami::Repository
  associations do
    belongs_to :post
  end

  prepend ImageAttachment.repository(:image)
end
