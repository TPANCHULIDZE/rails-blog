class PostsController < ApplicationController
  include PostsSupport
  
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
end

