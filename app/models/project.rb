class Project < ApplicationRecord
  belongs_to :admin, optional: true  # A project can exist without an admin
  has_and_belongs_to_many :faculties, join_table: "project_faculties"
  has_many :applications, dependent: :destroy
  has_many :saved_projects, dependent: :destroy
  has_many :students, through: :saved_projects # Access students who saved the project

  validates :title, :num_positions, :areas_of_research, :start_semester, presence: true
  # Add other validations as needed (e.g., length, numericality)
end
