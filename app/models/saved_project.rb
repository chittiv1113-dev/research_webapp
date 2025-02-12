class SavedProject < ApplicationRecord
  belongs_to :student
  belongs_to :project
    validates :student_id, uniqueness: {scope: :project_id, message: "has already saved this project."}
end
