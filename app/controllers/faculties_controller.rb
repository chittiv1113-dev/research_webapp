# app/controllers/faculties_controller.rb
class FacultiesController < ApplicationController
    before_action :set_faculty, only: %i[show edit update destroy]
  
    def index
      @faculties = Faculty.all
    end
  
    def show
    end
  
    def new
      @faculty = Faculty.new
    end
  
    def create
      # 1) Read the form inputs (department, name, email) out of faculty_params
      dept  = faculty_params[:department]
      name  = faculty_params[:name]
      email = faculty_params[:email]
  
      # 2) Find or create user by email
      user = User.find_by(email: email)
      unless user
        user = User.new(
          name:     name,
          email:    email,
          provider: "manual",
          uid:      SecureRandom.uuid
        )
      end
  
      # If user already exists, optionally update the name (if you want to overwrite)
      # user.name = name  # uncomment if you want to always sync their name from the form
  
      # 3) Build the faculty
      @faculty = Faculty.new(department: dept)
      @faculty.user = user
  
      # 4) Attempt to save everything
      #    If the user is brand new, saving @faculty will also save the user (because of belongs_to)
      #    But if user is existing, we must ensure user valid? first or do user.save
      Faculty.transaction do
        # Save the user first, so that if there's an error (e.g. email invalid, validations, etc.),
        # we don't create the Faculty either.
        user.save!  # might fail if invalid
        @faculty.save!  # might fail if department blank, etc.
      end
  
      redirect_to faculties_path, notice: "Faculty was successfully created."
    rescue ActiveRecord::RecordInvalid
      # If user or faculty fails validation, we come here
      # We want to re-display the form with the errors
      copy_form_attributes(@faculty, name, email)
      render :new, status: :unprocessable_entity
    end
  
    def edit
      # Pre-populate the form with existing faculty, user name/email
      @faculty.name  = @faculty.user.name
      @faculty.email = @faculty.user.email
    end
  
    def update
      dept  = faculty_params[:department]
      name  = faculty_params[:name]
      email = faculty_params[:email]
  
      @faculty.department = dept
  
      user = @faculty.user
      # Optionally update user's name/email
      # You could also check if the email changed to find another user, etc.
      user.name  = name
      user.email = email
  
      # "manual" logic to ensure provider/uid if they're blank
      user.provider = "manual" if user.provider.blank?
      user.uid      = SecureRandom.uuid if user.uid.blank?
  
      Faculty.transaction do
        user.save!
        @faculty.save!
      end
  
      redirect_to faculties_path, notice: "Faculty was successfully updated."
    rescue ActiveRecord::RecordInvalid
      copy_form_attributes(@faculty, name, email)
      render :edit, status: :unprocessable_entity
    end
  
    def destroy
      @faculty.destroy
      redirect_to faculties_path, notice: "Faculty was successfully destroyed."
    end
  
    private
  
    # Because `:name` and `:email` are not real columns on Faculty,
    # we must permit them and store them in the model's virtual attributes.
    def faculty_params
      params.require(:faculty).permit(:department, :name, :email)
    end
  
    def set_faculty
      @faculty = Faculty.find(params[:id])
    end
  
    # A small helper to ensure we keep the typed-in name/email if there's an error
    def copy_form_attributes(faculty, name, email)
      faculty.name  = name
      faculty.email = email
    end
  end
  