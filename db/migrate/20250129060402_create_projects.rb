class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.string :title
      t.text :description
      t.references :faculty, null: false, foreign_key: true
      t.boolean :is_active

      t.timestamps
    end
  end
end
