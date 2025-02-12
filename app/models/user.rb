class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  devise :omniauthable, omniauth_providers: [:google_oauth2]

  has_one :student, dependent: :destroy
  has_one :faculty, dependent: :destroy
  has_one :admin, dependent: :destroy

  def self.from_google(email:, name:, uid:, provider:)
    # Find user by email
    # If not found, create one
    user = find_or_create_by(email: email) do |u|
      u.uid = uid
      u.provider = provider
      u.name = name
      # u.password = Devise.friendly_token[0,20] # Generate a random password
    end

    # If user isn't connected to a role, then we hardcode it for now.
    # Can create association with user model.
    if user.student.nil? && user.faculty.nil? && user.admin.nil?
      role = case email
             when "admin@example.com" # Replace with your admin email(s)
               :admin
             when "faculty@example.com" # Replace with faculty email(s)
               :faculty
             else
               :student # Default to student
             end

      # Create new user, and build association.
      case role
      when :admin
        user.create_admin!
      when :faculty
        user.create_faculty!
      when :student
        user.create_student!
      end
    end
    user
  end

  # Helper methods to check the user's role.
  def admin?
    admin.present?
  end

  def faculty?
    faculty.present?
  end

  def student?
    student.present?
  end
end
