class User < ApplicationRecord
  devise :omniauthable, omniauth_providers: [:google_oauth2]

  has_one :student, dependent: :destroy
  has_one :faculty, dependent: :destroy
  has_one :admin, dependent: :destroy

  # Add validations, even though we use OAuth.
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :name, presence: true
  validates :uid, presence: true
  validates :provider, presence: true

  def self.from_google(email:, name:, uid:, provider:)
    user = find_or_initialize_by(email: email) # Use initialize

    if user.new_record?  # Only set attributes if it's a new record
        user.uid = uid
        user.provider = provider
        user.name = name
        # user.password = Devise.friendly_token[0,20] # Set a random password
        user.save! #Explicit save, so we can call .create_admin! and others

        role = case email
               when "admin@example.com"
                 :admin
               when "faculty@example.com"
                 :faculty
               else
                 :student
               end

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
