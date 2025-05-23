class Project < ApplicationRecord
  belongs_to :admin, optional: true  # A project can exist without an admin
  has_and_belongs_to_many :faculties, join_table: "project_faculties"
  has_many :applications, dependent: :destroy
  has_many :saved_projects, dependent: :destroy
  has_many :students, through: :saved_projects # Access students who saved the project

  validates :title, presence: true, length: { maximum: 255 } # Title: Required, max 255 chars
  validates :description, presence: true, length: { maximum: 1000 } # Description: Required, max 1000 chars (adjust as needed)
  validates :num_positions, presence: true, length: { maximum: 10 }
  validates :areas_of_research, presence: true, length: { maximum: 500 } # Areas of Research: Required, max 500 chars (adjust as needed)
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :prefered_class, length: { maximum: 255 }, allow_blank: true # Preferred Class: Optional, max 255 chars
  validates :other_comments, length: { maximum: 1000 }, allow_blank: true # Other Comments: Optional, max 1000 chars (adjust as needed)  # Add other validations as needed (e.g., length, numericality)
end
