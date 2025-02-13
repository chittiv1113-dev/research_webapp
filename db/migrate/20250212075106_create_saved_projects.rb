class CreateSavedProjects < ActiveRecord::Migration[8.0] # Your Rails version
  def change
    create_table :saved_projects do |t|
      t.references :student, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true
      t.timestamps
    end
  end
end
