class PostsAutocomplete < MiddlewareAutocomplete::Base
  def self.search(params)
    Post.where("title LIKE ?", "#{params['q']}_%")
        .order(:title).limit(10).pluck(:title).to_json
  end
end