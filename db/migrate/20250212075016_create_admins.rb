
class CreateAdmins < ActiveRecord::Migration[8.0] # Use the correct version
  def change
    create_table :admins do |t|
      t.references :user, null: false, foreign_key: true # This is correct

      # Add any Admin-SPECIFIC fields here (if any).  For example:
      # t.string :office_location
      # t.string :title

      t.timestamps
    end
  end
end
