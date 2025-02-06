class CreateProjectFaculties < ActiveRecord::Migration[7.1] # Use your Rails version
  def change
    create_table :project_faculties, id: false do |t| # Remove the default primary key
      t.references :project, null: false, foreign_key: true
      t.references :faculty, null: false, foreign_key: true
    end
    add_index :project_faculties, [:project_id, :faculty_id], unique: true #Composite Key
  end
end
