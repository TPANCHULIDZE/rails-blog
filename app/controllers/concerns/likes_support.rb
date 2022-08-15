module LikesSupport

  private

    def set_post
      @post = Post.find_by(id: params[:post_id])
    end

    def set_like
      @like = Like.find_by(id: params[:id])
    end
end