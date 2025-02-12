
class Admin < ApplicationRecord
  belongs_to :user
    has_many :projects, dependent: :nullify #or :destroy
end

