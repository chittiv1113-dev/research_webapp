# app/controllers/applications_controller.rb
class ApplicationsController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :create ] # Must be logged in to apply
  before_action :set_project, only: [ :new, :create ]
  # Optional: Add authorization check to ensure only students can apply
  # before_action :require_student, only: [:new, :create]
  before_action :require_student_or_admin, only: [ :new, :create ] # <-- ADD THIS LINE

  # Action for the landing page (root)
  def landing
    # Can add logic here if the landing page needs dynamic data
  end

  # Action to display the application form
  def new
    # @project is set by before_action
    # No Application model instance needed as we aren't saving to DB
  end

  # Action to process form submission and send email
  def create
    # @project is set by before_action

    # 1. Extract application data from params
    #    Use a whitelist approach for security
    application_data = params.permit(
      :last_name, :first_name, :uin, :tamu_email,
      :interest_reason, :personal_projects, :relevant_classes,
      :work_experience, :github_link
    ).to_h.with_indifferent_access # Use hash with indifferent access

    # 2. Basic Validation (Example: Check required fields)
    required_fields = [ :last_name, :first_name, :uin, :tamu_email, :interest_reason ]
    missing_fields = required_fields.select { |f| application_data[f].blank? }

    unless missing_fields.empty?
      flash.now[:alert] = "Please fill in all required fields: #{missing_fields.map(&:to_s).map(&:titleize).join(', ')}"
      render :new, status: :unprocessable_entity # Re-render the form with errors
      return
    end

    # 3. Identify recipients
    recipient_emails = []
    # Add faculty emails
    recipient_emails.concat(@project.faculties.includes(:user).map { |f| f.user&.email })
    # Add admin creator email (if project has one and it's different)
    recipient_emails << @project.admin&.user&.email if @project.admin.present?
    # Add specific admins if needed (e.g., Stephanie Vilas from landing page)
    # recipient_emails << "stephanie.vilas@tamu.edu" # Example: Hardcoded or from config

    recipient_emails = recipient_emails.compact.uniq.reject(&:blank?)

    if recipient_emails.empty?
       # Log this error, maybe notify site admin
       Rails.logger.error "No recipients found for project application #{@project.id}. Applicant: #{current_user.email}"
       flash[:alert] = "Could not determine who to send the application to. Please contact support."
       redirect_to project_path(@project)
       return
    end


    # 4. Send the email (use deliver_later for background sending)
    begin
      ApplicationNotificationMailer.submit_application(
        applicant: current_user,
        project: @project,
        application_data: application_data,
        recipients: recipient_emails
      ).deliver_now # Use deliver_later for background processing

      # 5. Set success feedback and redirect
      flash[:notice] = "Your application for '#{@project.title}' has been submitted successfully."
      redirect_to projects_path # Redirect back to the project list
    rescue StandardError => e
      # Log the error
      Rails.logger.error "Failed to send application email for project #{@project.id}. Error: #{e.message}"
      flash[:alert] = "There was an error submitting your application. Please try again later or contact support."
      render :new, status: :unprocessable_entity # Or redirect to project page
    end
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "The project you are trying to apply for could not be found."
    redirect_to projects_path
  end

  # Optional: Add if you only want students to apply
  def require_student
    unless current_user.student? # Assumes student? method exists on User model
      flash[:alert] = "Only students can submit applications."
      redirect_to projects_path
    end
  end
  def require_student_or_admin
    unless current_user.student? || current_user.admin?
      flash[:alert] = "You are not authorized to perform this action. Only students or administrators can apply."
      redirect_to projects_path # Redirect non-students/admins away
    end
  end
end
