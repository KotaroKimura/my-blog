module Web::Views::Posts
  class Show
    include Web::View

    def render_json
      raw JSON.generate(
        {
          id:         post.id,
          title:      post.title,
          body:       post.body,
          created_at: post.created_at,
          updated_at: post.updated_at 
        }
      )
    end
  end
end
