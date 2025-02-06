class Project < ApplicationRecord
  belongs_to :admin, foreign_key: :created_by_admin
  has_and_belongs_to_many :faculties
  has_many :applications, dependent: :destroy
  has_many :saved_projects, dependent: :destroy
   has_many :students, through: :saved_projects
  validates :title, :num_positions, :areas_of_research, :start_semester, presence:true
end
