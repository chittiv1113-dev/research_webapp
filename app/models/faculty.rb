class Faculty < ApplicationRecord
  belongs_to :admin, foreign_key: :created_by_admin
  has_and_belongs_to_many :projects
  validates :name, :email, presence: true
   validates :email, uniqueness: true
end
