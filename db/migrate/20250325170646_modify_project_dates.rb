class ModifyProjectDates < ActiveRecord::Migration[8.0]
  def change
    remove_column :projects, :expires_at, :datetime
    remove_column :projects, :start_semester, :string
    remove_column :projects, :start_year, :integer
    add_column :projects, :start_date, :date
    add_column :projects, :end_date, :date
  end
end
