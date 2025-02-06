class CreateStudents < ActiveRecord::Migration[8.0]
  def change
    create_table :students do |t|
      t.string :name
      t.integer :year
      t.string :major
      t.string :email

      t.timestamps
    end
    add_index :students, :email, unique: true
  end
end
