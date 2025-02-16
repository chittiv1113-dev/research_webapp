# app/controllers/projects_controller.rb
class ProjectsController < ApplicationController
  before_action :authorize_faculty_admin, only: [ :new, :create ]
  def index
    @projects = Project.all

    if params[:search].present?
      # Make a wildcard query for partial matches
      search_term = "%#{params[:search]}%"

      # We can search across multiple columns, including faculty’s user name.
      # Using ILIKE for case-insensitive search in PostgreSQL
      @projects = @projects.joins(faculties: :user)
                           .where("projects.title ILIKE :term
                                   OR projects.areas_of_research ILIKE :term
                                   OR projects.start_semester ILIKE :term
                                   OR projects.prefered_class ILIKE :term
                                   OR users.name ILIKE :term",
                                  term: search_term)
    end
  end

  def new
    @project = Project.new
  end


  # app/controllers/projects_controller.rb
  def create
    @project = Project.new(project_params)
    if @project.save
      Rails.logger.debug "--- Project Created ---"
      Rails.logger.debug "Current User is Admin? #{current_user.admin?}" # Log admin status
      Rails.logger.debug "Current User: #{current_user.inspect}"

      if current_user.admin?
        Rails.logger.debug "Associating Admin creator: #{current_user.admin.inspect}"
        @project.admin = current_user.admin  # Explicitly set admin association
      end
      @project.faculties << current_user.faculty if current_user.faculty

      redirect_to projects_path, notice: "Project was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def project_params
    params.require(:project).permit(
      :title, :description, :num_positions, :areas_of_research,
      :start_semester, :prefered_class, :other_comments
    )
  end

  def authorize_faculty_admin
    unless current_user_is_faculty_or_admin?
      redirect_to root_path, alert: "You are not authorized to create projects."
    end
  end

  def current_user_is_faculty_or_admin?
    current_user.admin? || current_user.faculty?
  end
end
