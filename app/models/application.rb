class Application < ApplicationRecord
  belongs_to :student
  belongs_to :project

  validates :status, presence: true
  # Add other validations as needed (e.g., uniqueness of student/project combination)
  validates :student_id, uniqueness: { scope: :project_id, message: "has already applied to this project" }
end
