
class AdminsController < ApplicationController
  before_action :set_admin, only: [ :edit, :update, :destroy ]
  before_action :require_admin

  def dashboard
    # This action will now only be accessible by admins.
    # No specific data loading needed for the view you provided.
  end
  def show
  end
  def dashboard
  end


  def index
    @admins = Admin.all
  end

  def new
    @admin = Admin.new
  end



  def create
    email = admin_params[:email]
    name  = admin_params[:name]

    # Look for an existing user by email (case-insensitive)
    user = User.find_by("LOWER(email) = ?", email.downcase)
    if user
      if user.admin
        # The user is *already a student* => block
        flash[:alert] = "An admin with that email already exists."
        redirect_to new_admin_path and return
      else
        user.name = name if name.present?
      end
    else
      user = User.new(
        name:     name,
        email:    email,
        provider: "manual",
        uid:      SecureRandom.uuid
      )
    end

    ActiveRecord::Base.transaction do
      user.save!
      @admin = Admin.create!(user: user)
    end

    redirect_to admins_path, notice: "Admin was successfully created."
  rescue ActiveRecord::RecordInvalid => e
    flash.now[:alert] = e.message
    render :new, status: :unprocessable_entity
  end

  def edit
    # @admin is set by set_admin
  end

  def update
    email = admin_params[:email]
    name  = admin_params[:name]

    user = @admin.user
    user.email = email if email.present?
    user.name  = name  if name.present?

    ActiveRecord::Base.transaction do
      user.save!
      @admin.save!
  end

    redirect_to admins_path, notice: "Admin was successfully updated."
  rescue ActiveRecord::RecordInvalid => e
    flash.now[:alert] = e.message
    render :edit, status: :unprocessable_entity
  end

  def destroy
    @admin.destroy
    redirect_to admins_path, notice: "Admin was successfully deleted."
  end

  private

  def set_admin
    @admin = Admin.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to admins_path, alert: "Admin not found."
  end

  def admin_params
    params.require(:admin).permit(:email, :name)
  end
end
