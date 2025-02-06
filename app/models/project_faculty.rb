
class ProjectFaculty < ApplicationRecord
  belongs_to :project
  belongs_to :faculty
end
