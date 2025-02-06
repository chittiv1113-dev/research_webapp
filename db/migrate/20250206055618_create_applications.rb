class CreateApplications < ActiveRecord::Migration[7.1]
  def change
    create_table :applications do |t|
      t.references :student, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true
      t.datetime :application_date, default: -> { 'CURRENT_TIMESTAMP' }
      t.string :status, limit: 50, default: 'pending'
      t.timestamps
    end
  end
end
