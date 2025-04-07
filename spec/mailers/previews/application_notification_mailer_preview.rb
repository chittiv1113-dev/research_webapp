# Preview all emails at http://localhost:3000/rails/mailers/application_notification_mailer
class ApplicationNotificationMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/application_notification_mailer/submit_application
  def submit_application
    ApplicationNotificationMailer.submit_application
  end

end
