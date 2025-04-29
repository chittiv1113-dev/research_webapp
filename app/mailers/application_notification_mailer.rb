# app/mailers/application_notification_mailer.rb
class ApplicationNotificationMailer < ApplicationMailer
  # Set a default reply-to if desired, or handle in method
  # default reply_to: -> { @applicant.email } # Requires @applicant to be set

  def submit_application(applicant:, project:, application_data:, recipients:)
    @applicant = applicant # Student User object
    @project = project
    @application_data = application_data # Hash of form fields
    @recipients = recipients # Array of email addresses

    # Ensure recipients is an array and not empty
    valid_recipients = Array(@recipients).reject(&:blank?)
    return if valid_recipients.empty? # Don't try to send if no valid recipients

    mail(
      to: valid_recipients,
      subject: "Research Application Submitted: #{@project.title} - #{@application_data[:last_name]}, #{@application_data[:first_name]}",
      reply_to: @applicant.email # Set reply-to the student's email
    )
  end
end
