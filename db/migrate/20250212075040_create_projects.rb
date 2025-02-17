class CreateProjects < ActiveRecord::Migration[7.2]
  def change
    create_table :projects do |t|
      t.string :title, null: false
      t.text :description
      t.integer :num_positions, null: false
      t.text :areas_of_research, null: false
      t.string :start_semester, null: false
      t.string :prefered_class
      t.text :other_comments
      t.boolean :is_active, default: true
      t.datetime :filled_at
      t.datetime :expires_at
      t.references :admin, foreign_key: true, null: true
      t.timestamps
    end
  end
end
