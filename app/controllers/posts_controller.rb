class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy index ]
  before_action :authenticate_admin!, only: %i[ new edit update destroy create ]
  before_action :set_opengraph_values
  before_action :validate_index_params, only: :index
  # GET /posts
  def index
    respond_to do |format|
      format.json do
        @limit = 5
        @posts = Post.where(project:false).where(published: ..(DateTime.parse(params[:before]))).where.not(published: DateTime.parse(params[:before])).order(published: :desc).last(@limit)
        render json: {
          limit: @limit,
          count: @posts.length,
          oldest: @posts.last ? @posts.last.published : "",
          html: render_to_string(partial:'post_index')
        }
      end
      format.html
    end

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

    def set_opengraph_values
      super
      return unless @post
      @og[:title] = @post.title
      @og[:image] = helpers.url_for(@post.hero_image) if @post.hero_image.attached?
      @og[:description] = @post.hook if @post.hook
      @og[:type] = "article"
      @og["article:puiblished_time"] = @post.published.iso8601 if @post.published
      @og["article:author"] = "Daniel Cavazos"
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit( :title, :content, :published, :hook, :project, :hero_image)
    end
    # Only allow a list of trusted parameters through.
    def validate_index_params
      if request.format == :json
        params.require(:before)
      end
    end
end
