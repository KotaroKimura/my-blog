class PostRepository < Hanami::Repository
  def paginate_by(offset: _offset, limit: _limit)
    posts.order { created_at.desc }.offset(offset).limit(limit).call.collection
  end
end
