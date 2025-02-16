require 'rails_helper'

RSpec.describe Project, type: :model do
  describe 'associations' do
    it 'has and belongs to many faculties' do
      association = Project.reflect_on_association(:faculties)
      expect(association.macro).to eq(:has_and_belongs_to_many)
    end

    it 'belongs to admin' do
      association = Project.reflect_on_association(:admin)
      expect(association.macro).to eq(:belongs_to)
    end
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      project = build(:project) # Using FactoryBot to create a valid project (define factories later)
      expect(project).to be_valid
    end

    it 'is not valid without a title' do
      project = build(:project, title: nil)
      expect(project).to_not be_valid
      expect(project.errors[:title]).to include("can't be blank")
    end

    it 'is not valid if title is too long' do
      project = build(:project, title: 'a' * 256)
      expect(project).to_not be_valid
      expect(project.errors[:title]).to include("is too long (maximum is 255 characters)")
    end

    it 'is not valid without a description' do
      project = build(:project, description: nil)
      expect(project).to_not be_valid
      expect(project.errors[:description]).to include("can't be blank")
    end

    it 'is not valid if description is too long' do
      project = build(:project, description: 'a' * 1001)
      expect(project).to_not be_valid
      expect(project.errors[:description]).to include("is too long (maximum is 1000 characters)")
    end

    it 'is not valid without num_positions' do
      project = build(:project, num_positions: nil)
      expect(project).to_not be_valid
      expect(project.errors[:num_positions]).to include("can't be blank")
    end
    
    it 'is not valid if num_positions is too long (string length)' do # New test for string length
      project = build(:project, num_positions: '12345678901') # 11 characters
      expect(project).to_not be_valid
      expect(project.errors[:num_positions]).to include("is too long (maximum is 10 characters)")
    end

    it 'is valid if num_positions is a string within length limit' do # New test for valid string
      project = build(:project, num_positions: '5') # Valid string within length
      expect(project).to be_valid
    end

    it 'is valid if num_positions is a string with max length' do # New test for max length string
      project = build(:project, num_positions: '1234567890') # Valid string with max length
      expect(project).to be_valid
    end
    
    it 'is not valid without areas_of_research' do
      project = build(:project, areas_of_research: nil)
      expect(project).to_not be_valid
      expect(project.errors[:areas_of_research]).to include("can't be blank")
    end

    it 'is not valid if areas_of_research is too long' do
      project = build(:project, areas_of_research: 'a' * 501)
      expect(project).to_not be_valid
      expect(project.errors[:areas_of_research]).to include("is too long (maximum is 500 characters)")
    end

    it 'is not valid without start_semester' do
      project = build(:project, start_semester: nil)
      expect(project).to_not be_valid
      expect(project.errors[:start_semester]).to include("can't be blank")
    end

    it 'is not valid if start_semester is too long' do
      project = build(:project, start_semester: 'a' * 51)
      expect(project).to_not be_valid
      expect(project.errors[:start_semester]).to include("is too long (maximum is 50 characters)")
    end

    it 'is valid if prefered_class is blank' do
      project = build(:project, prefered_class: nil)
      expect(project).to be_valid
    end

    it 'is not valid if prefered_class is too long' do
      project = build(:project, prefered_class: 'a' * 256)
      expect(project).to_not be_valid
      expect(project.errors[:prefered_class]).to include("is too long (maximum is 255 characters)")
    end

    it 'is valid if other_comments is blank' do
      project = build(:project, other_comments: nil)
      expect(project).to be_valid
    end

    it 'is not valid if other_comments is too long' do
      project = build(:project, other_comments: 'a' * 1001)
      expect(project).to_not be_valid
      expect(project.errors[:other_comments]).to include("is too long (maximum is 1000 characters)")
    end
  end
end
