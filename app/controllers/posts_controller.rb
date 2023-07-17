class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy index ]
  before_action :authenticate_admin!, only: %i[ new edit update destroy create ]
  # GET /posts
  def index
    if @post
      @posts = Post.select(:id, :title, :hook, :project).where.not(id:@post.id).where(project:false)
      unless admin_signed_in?
        @posts = @posts.where(published: ..(DateTime.now()))
      end
      @posts = @posts.last(6)
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
      unless params[:id]
        @post = Post.with_rich_text_content_and_embeds.order(:published).where(project:false)
        unless admin_signed_in?
          @post = @post.where(published: ..(DateTime.now()))
        end
        @post = @post.last
        return
      end
      @post = Post.with_rich_text_content_and_embeds.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit( :title, :content, :published, :hook, :project, :hero_image)
    end
end