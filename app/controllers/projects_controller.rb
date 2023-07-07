class ProjectsController < ApplicationController
  # GET /posts
  def index
    @projects = Post.select(:id, :title, :hook, :project).where(project:true)
  end

  # GET /posts/1
  def show
    @projects = Post.with_rich_text_content_and_embeds.find(params[:id])
  end
end
