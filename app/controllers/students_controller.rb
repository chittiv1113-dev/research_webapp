class StudentsController < ApplicationController
    before_action :set_student, only: [:show, :edit, :update, :destroy]
  
    def index
      @students = Student.all
    end
  
    def show
    end
  
    def new
      @student = Student.new
    end
  
    def create
      # Pull parameters from the form
      email = student_params[:email]
      name  = student_params[:name]
      year  = student_params[:year]
      major = student_params[:major]
  
      user = User.find_by(email: email.downcase)
      unless user
        # If no existing user with that email, create one with "manual" provider/uid
        user = User.new(
          name:     name,  # can be blank if not provided
          email:    email,
          provider: "manual",
          uid:      SecureRandom.uuid
        )
      end
      # Optionally sync the user's name each time
      # user.name = name if name.present?
  
      ActiveRecord::Base.transaction do
        user.save!
        @student = Student.create!(
          user: user,
          year: year,
          major: major
        )
      end
  
      redirect_to students_path, notice: "Student was successfully created."
    rescue ActiveRecord::RecordInvalid => e
      @student = Student.new(
        year: year,
        major: major
      )
      @student.errors.add(:base, e.message) if @student.errors.empty?
      render :new, status: :unprocessable_entity
    end
  
    def edit
      # Pre-fill form fields from the existing record
      # We'll do that in the view (for year, major).
      # If you want to also show user email/name, you can do so there as well.
    end
  
    def update
      email = student_params[:email]
      name  = student_params[:name]
      year  = student_params[:year]
      major = student_params[:major]
  
      user = @student.user
      user.email = email if email.present?
      # user.name = name if name.present?
  
      @student.year = year
      @student.major = major
  
      ActiveRecord::Base.transaction do
        user.save!
        @student.save!
      end
  
      redirect_to students_path, notice: "Student was successfully updated."
    rescue ActiveRecord::RecordInvalid => e
      @student.errors.add(:base, e.message) if @student.errors.empty?
      render :edit, status: :unprocessable_entity
    end
  
    def destroy
      @student.destroy
      redirect_to students_path, notice: "Student was successfully destroyed."
    end
  
    private
  
    def set_student
      @student = Student.find(params[:id])
    end
  
    def student_params
      # Only email is strictly required. name, year, major are optional.
      params.require(:student).permit(:email, :name, :year, :major)
    end
  end
  