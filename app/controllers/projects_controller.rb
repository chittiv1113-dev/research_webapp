# app/controllers/projects_controller.rb
class ProjectsController < ApplicationController
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
end
