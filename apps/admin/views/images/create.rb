module Admin
  module Views
    module Images
      class Create
        include Admin::View

        def render_json
          raw JSON.generate(
            {
              id:         _image.id,
              name:       _image.name,
              image_url:  "/uploads/store/#{_image.image.data['id']}",
              created_at: _image.created_at,
              updated_at: _image.updated_at 
            }
          )
        end
      end
    end
  end
end
