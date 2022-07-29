class CommentsController < ApplicationController
  before_action :require_user_signed_in!
  before_action :set_post, only: %i[create destroy edit update]
  before_action :set_comment, only: %i[destroy edit update]

  def create
    @comment = current_user.comments.new(comment_params)
    @comment.post = @post
    if @comment.save
      flash[:notice] = "create new comment"
    else
      flash[:alert] = "comment can't be empty"
    end

    redirect_to @post
  end

  def destroy
    @comment.destroy
    redirect_to @post, status: 303, notice: "comment was deleted"
  end

  def update
    if @comment.update(comment_params)
      flash[:notice] = "update comment"
    else
      flash[:alert] = "comment not update"
    end
     
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
