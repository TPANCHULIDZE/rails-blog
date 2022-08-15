module CommentsSupport
  
  private

    def comment_params
      params.require(:comment).permit(:author, :body)
    end

    def set_post
      @post = Post.find_by(id: params[:post_id])
    end

    def set_comment
      @comment = Comment.find_by(id: params[:id])
    end
end