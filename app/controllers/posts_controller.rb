class PostsController < ApplicationController
  before_action :require_user_signed_in!
  before_action :set_post, only: %i[show edit update destroy approve_post]
  before_action :set_user, only: %i[show]
  before_action :require_authorize_post!, only: %i[edit update destroy show approve_post]

  decorates_assigned :post, :posts, :comments, :user

  def index
    @q = Post.ransack(params[:q])
    @q.sorts = 'name asc' if @q.sorts.empty?
    @posts = @q.result(distinct: true).where(approve: true).paginate(page: params[:page], per_page: 10)
  end

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

  def show
    @comments = @post.comments.order("created_at DESC").paginate(page: params[:page], per_page: 2)
  end

  def new
    @post = Post.new
    authorize @post
  end

  def edit
  end

  def create
    @post = current_user.posts.new(post_params)
    authorize @post
    
    if @post.save
      redirect_to post_url(@post), notice: "Post was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
      redirect_to post_url(@post), notice: "Post was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy

    redirect_to posts_url, notice: "Post was successfully destroyed."
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

