class FacultiesController < ApplicationController
  before_action :set_faculty, only: [ :show, :edit, :update, :destroy ]

  def index
    @faculties = Faculty.all
  end

  def show
  end

  def new
    @faculty = Faculty.new
  end

  def create
    # Get the inputs from the form (only email is mandatory)
    dept  = faculty_params[:department]
    name  = faculty_params[:name]
    email = faculty_params[:email]

    user = User.find_by(email: email.downcase)
    unless user
      # Create a new user with minimal "manual" logic
      user = User.new(
        name:     name,     # can be blank if not provided
        email:    email,    # required
        provider: "manual",
        uid:      SecureRandom.uuid
      )
    end

    # Optionally update user.name if we want to sync the name from the form each time:
    # user.name = name if name.present?

    ActiveRecord::Base.transaction do
      user.save!
      @faculty = Faculty.create!(user: user, department: dept)
    end

    redirect_to faculties_path, notice: "Faculty was successfully created."
  rescue ActiveRecord::RecordInvalid => e
    # If user or faculty fails validation, re-render :new with errors
    @faculty = Faculty.new(department: dept)
    @faculty.errors.add(:base, e.message) if @faculty.errors.empty?
    render :new, status: :unprocessable_entity
  end

  def edit
    # If you want to pre-fill name, do so from @faculty.user
  end

  def update
    dept  = faculty_params[:department]
    name  = faculty_params[:name]
    email = faculty_params[:email]

    user = @faculty.user
    # If you want to let them edit the user’s email, you can do this:
    user.email = email if email.present?
    # user.name  = name if name.present?

    @faculty.department = dept

    ActiveRecord::Base.transaction do
      user.save!
      @faculty.save!
    end

    redirect_to faculties_path, notice: "Faculty was successfully updated."
  rescue ActiveRecord::RecordInvalid => e
    @faculty.errors.add(:base, e.message) if @faculty.errors.empty?
    render :edit, status: :unprocessable_entity
  end

  def destroy
    @faculty.destroy
    redirect_to faculties_path, notice: "Faculty was successfully destroyed."
  end

  private

  def set_faculty
    @faculty = Faculty.find(params[:id])
  end

  def faculty_params
    # name and department are optional, but we'll permit them
    # email is required from the form's standpoint
    params.require(:faculty).permit(:email, :name, :department)
  end
end
