class PostsController < ApplicationController
  before_action :require_user_signed_in!
  before_action :require_user_is_member! 
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :set_user, only: %i[show]

  decorates_assigned :post, :posts, :comments, :user

  # GET /posts or /posts.json
  def index
    @posts = Post.paginate(page: params[:page], per_page: 2)
  end

  def user_posts
    @user = User.find_by(id: params[:id])
    @posts = @user.posts.paginate(page: params[:page], per_page: 2)
  end

  # GET /posts/1 or /posts/1.json
  def show
    @comments = @post.comments.order("created_at DESC").paginate(page: params[:page], per_page: 2)
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = current_user.posts.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to post_url(@post), notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    def set_user
      @user = @post.user
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :body, :user_id)
    end

    def require_user_is_member!
      redirect_to root_path unless current_user.member? || current_user.admin?
    end
end

