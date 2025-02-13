class CreateStudents < ActiveRecord::Migration[8.0]
  def change
    create_table :students do |t|
      t.references :user, null: false, foreign_key: true
      # t.string :name
      # t.string :email
      t.integer :year
      t.string :major

      t.timestamps
    end
  end
end
