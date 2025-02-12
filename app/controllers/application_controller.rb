class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  before_action :authenticate_user!  # Use authenticate_user! for Devise with User model
  allow_browser versions: :modern

  # Add this to make current_user available in views (optional, but good practice)
  helper_method :current_user

  # Add Pundit authorization (we'll set this up later, but include it now)
  # include Pundit::Authorization

  # Rescue from Pundit errors (also for later, when we implement authorization)
  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_back(fallback_location: root_path)
  end

end
