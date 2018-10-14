module Web::Views::Posts
  class Index
    include Web::View

    def render_json
      raw JSON.generate(
        posts.map do |_p|
          {
            id:         _p.id,
            title:      _p.title,
            body:       _p.body,
            created_at: _p.created_at,
            updated_at: _p.updated_at 
          }
        end
      )
    end
  end
end
