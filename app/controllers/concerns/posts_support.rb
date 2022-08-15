module PostsSupport
  def unapprove_posts
    @user = User.find_by(id: params[:user_id])
    @q = Post.ransack(params[:q])
    if current_user.admin?
      @posts = @q.result(distinct: true).where(approve: false).paginate(page: params[:page], per_page: 10)
    else
      @posts = @q.result(distinct: true).where(user_id: params[:user_id], approve: false).paginate(page: params[:page], per_page: 10)
    end
  end

  def approve_post
    redirect_to root_path, alert: "you are not allowed for this action" unless current_user.admin?
     
    @post.update(approve: true)
    mail = UsersMailer.approve_post(@post.user_id)
    mail.deliver_now
    redirect_to @post
  end

  def user_posts
    @user = User.find_by(id: params[:id])
    @q = @user.posts.ransack(params[:q])
    @posts = @q.result(distinct: true).where(approve: true).paginate(page: params[:page], per_page: 10)
  end

  private

    def set_post
      @post = Post.find_by(id: params[:id])
    end

    def require_authorize_post!
      authorize @post
    end

    def set_user
      if @post
        @user = @post.user 
      else
        redirect_to root_path, alert: "this post not exist"
      end
    end

    def post_params
      params.require(:post).permit(:title, :body, :member_only)
    end
end