class CommentsController < ApplicationController
  before_action :set_post, only: %i[create destroy edit update]
  before_action :set_comment, only: %i[destroy edit update]

  def new
  end

  def create
    @comment = current_user.comments.new(comment_params)
    @comment.post = @post
    @comment.save
    redirect_to @post
  end

  def destroy
    @comment.destroy
    redirect_to @post
  end

  def edit
  end

  def update
    @comment.update(comment_params)
    redirect_to @post
  end


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
