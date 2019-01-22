class PostRepository < Hanami::Repository
  associations do
    has_many :images
  end

  def paginate_by(offset: _offset, limit: _limit, published_state: 2)
    posts.where(published_state: published_state).order { created_at.desc }.offset(offset).limit(limit).call.collection
  end

  def find_with_images id
    aggregate(:images).where(id: id).map_to(Post).one
  end
end
