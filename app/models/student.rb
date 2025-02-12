class Student < ApplicationRecord
  belongs_to :user
    validates :year, :major, presence: true
end
