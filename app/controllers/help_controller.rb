# app/controllers/help_controller.rb
class HelpController < ApplicationController
  # No authentication needed here, as we want even logged-out users to see general help
  # skip_before_action :authenticate_user! # Uncomment if you have a global authenticate_user! filter

  def show
    if user_signed_in?
      if current_user.admin?
        render "admin_help" # Specific help view for admins (project creation focus)
      elsif current_user.faculty?
        render "faculty_help"
      elsif current_user.student?
        render "student_help"
      else
        # Logged in, but no specific role (should ideally not happen with your setup, but handle just in case)
        render "general_help"
      end
    else
      # Not signed in
      render "general_help"
    end
  end
end
