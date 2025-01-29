class CreateApplications < ActiveRecord::Migration[6.1]
  def change
    create_table :applications do |t|
      t.references :student, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true
      t.datetime :application_date

      t.timestamps
    end
  end
end
