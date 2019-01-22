require 'mime/types'

module Admin
  module Views
    module Posts
      class Edit
        include Admin::View

        def render_json
          response_json = {
            id:              post.id,
            title:           post.title,
            body:            post.body,
            published_state: {},
            published_date:  post.published_date,
            created_at:      post.created_at,
            updated_at:      post.updated_at,
            images:          []
          }
          # push published_state data
          response_json[:published_state].tap do |j|
            j[:selected] = post.published_state
            j[:options]  = [
              { text: '下書き', value: 0 },
              { text: '公開待ち', value: 1 },
              { text: '公開済み', value: 2 },
            ]
          end

          # push images data
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
