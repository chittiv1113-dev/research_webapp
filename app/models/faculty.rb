class Faculty < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :projects, join_table: "project_faculties"
  validates :department, presence: true, length: { maximum: 255 } # Presence and max length for department
  # validates :email, presence: true, length: { maximum: 255 } # Presence and max length for emailend
end
