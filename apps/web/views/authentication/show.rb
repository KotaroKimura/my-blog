module Web::Views::Authentication
  class Show
    include Web::View

    def render_json
      raw JSON.generate(
        {
          api_token: api_token,
        }
      )
    end
  end
end
