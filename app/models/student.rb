class Student < ApplicationRecord
  has_many :applications, dependent: :destroy
  has_many :saved_projects, dependent: :destroy
    has_many :projects, through: :saved_projects
  validates :name, :email, presence: true
   validates :email, uniqueness: true
end
