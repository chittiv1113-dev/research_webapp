class ProjectsController < ApplicationController
  def index
    @projects = Project.all
    # Add filtering to this at some other point by keyword, department,, etc.
  end

  def show
    @project = Project.find(params[:id])
    # @tasks = @project.tasks
  end
end
