class Faculty < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :projects
    validates :department, presence: true
end
