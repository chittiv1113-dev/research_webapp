class CreateProjects < ActiveRecord::Migration[7.1] # Use your Rails version.
  def change
    create_table :projects do |t|
      t.string :title, null: false
      t.text :description
      t.integer :num_positions, null: false
      t.text :areas_of_research, null: false
      t.string :start_semester, limit: 50, null: false
      t.string :prefered_class, limit: 50
      t.text :other_comments
      t.boolean :is_active, default: true
      t.datetime :filled_at
      t.datetime :expires_at
      t.integer :created_by_admin, null: false
      t.timestamps
    end

    add_foreign_key :projects, :admins, column: :created_by_admin, primary_key: :id
  end
end
