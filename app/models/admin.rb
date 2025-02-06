class Admin < ApplicationRecord
  has_many :projects, foreign_key: :created_by_admin, dependent: :destroy
  has_many :faculties, foreign_key: :created_by_admin, dependent: :destroy
  validates :name, :email, presence: true
  validates :email, uniqueness: true
end
