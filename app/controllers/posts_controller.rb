class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :authenticate_admin!, only: %i[ new edit update destroy create ]
  # GET /posts
  def index
    @latest_post = Post.order(:published)
    unless admin_signed_in?
      @latest_post = @latest_post.where(published: ..(DateTime.now()), project:false).order(:published)
    end
    @latest_post = @latest_post.last
    if @latest_post
      @posts = Post.select(:id, :title, :hook, :project).where.not(id:@latest_post.id).where(project:false)
      unless admin_signed_in?
        @posts = @posts.where(published: ..(DateTime.now()))
      end
      @posts = @posts.last(5)
    end
  end

  # GET /posts/1
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to @post, notice: "Post was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      redirect_to @post, notice: "Post was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
    redirect_to posts_url, notice: "Post was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.with_rich_text_content_and_embeds.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit( :title, :content, :published, :hook, :project)
    end
end
