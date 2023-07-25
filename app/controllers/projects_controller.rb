class ProjectsController < ApplicationController
  before_action :validate_index_params, only: :index
  # GET /posts
  def index
    respond_to do |format|
      format.json do
        @limit = 5
        @projects = Post.where(project:true)#.where(published: ..(DateTime.parse(params[:before]))).where.not(published: DateTime.parse(params[:before])).order(published: :desc).last(@limit)
        render json: {
          limit: @limit,
          count: @projects.length,
          oldest: @projects.last ? @projects.last.published : "",
          html: render_to_string(partial:'project_index')
        }
      end
      format.html
    end
  end
  protected
  # Only allow a list of trusted parameters through.
  def validate_index_params
    if request.format == :json
      params.require(:before)
    end
  end
end
