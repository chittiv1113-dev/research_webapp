class CreateApplications < ActiveRecord::Migration[8.0]  # Your Rails version
  def change
    create_table :applications do |t|
      t.references :student, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true
      t.datetime :application_date
      t.string :status, default: "pending"
      t.timestamps
    end
  end
end
