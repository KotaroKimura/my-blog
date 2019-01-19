require 'mime/types'

module Admin
  module Views
    module Posts
      class Edit
        include Admin::View

        def render_json
          response_json = {
            id:         post.id,
            title:      post.title,
            body:       post.body,
            created_at: post.created_at,
            updated_at: post.updated_at,
            images:     []
          }
          post.images.each do |image|
            response_json[:images] << [
              image.name,
              "/uploads/store/#{image.image.data['id']}",
              MIME::Types.type_for("public/uploads/store/#{image.image.data['id']}")[0].to_s
            ]
          end

          raw JSON.generate(response_json)
        end
      end
    end
  end
end
