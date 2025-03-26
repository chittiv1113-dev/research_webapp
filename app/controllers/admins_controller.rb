
class AdminsController < ApplicationController
  before_action :require_admin
  
  def dashboard
    # This action will now only be accessible by admins.
    # No specific data loading needed for the view you provided.
  end
  def show
  end
  def dashboard
  end
end
