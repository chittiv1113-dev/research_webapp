class CreateFaculties < ActiveRecord::Migration[8.0]
  def change
    create_table :faculties do |t|
      t.references :user, null: false, foreign_key: true
      # t.string :name
      # t.string :email
      t.string :department

      t.timestamps
    end
  end
end
