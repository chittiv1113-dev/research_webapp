class CreateProjectFaculties < ActiveRecord::Migration[7.2]
  def change
    # No primary key, using composite key
    create_table :project_faculties, id: false do |t|
      t.references :project, null: false, foreign_key: true
      t.references :faculty, null: false, foreign_key: true
    end
      add_index :project_faculties, [ :project_id, :faculty_id ], unique: true
  end
end
