class ProjectsController < ApplicationController
  # GET /posts
  def index
    @projects = Post.select(:id, :title, :hook, :content, :published).where(project:true)
  end
end
