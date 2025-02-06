class CreateFaculties < ActiveRecord::Migration[8.0]
  def change
    create_table :faculties do |t|
      t.string :name, null: false
      t.string :department
      t.string :email, null: false
      t.integer :created_by_admin, null: false

      t.timestamps
    end
    add_index :faculties, :email, unique: true
    # add_index :faculties, :created_by_admin
    add_foreign_key :faculties, :admins, column: :created_by_admin, primary_key: :id
  end
end
