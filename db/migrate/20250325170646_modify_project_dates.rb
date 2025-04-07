class ModifyProjectDates < ActiveRecord::Migration[8.0]
  def change
      remove_column :projects, :expires_at, :datetime if column_exists?(:projects, :expires_at)
      remove_column :projects, :start_semester, :string if column_exists?(:projects, :start_semester)
      remove_column :projects, :start_year, :integer if column_exists?(:projects, :start_year)
    add_column :projects, :start_date, :date
    add_column :projects, :end_date, :date
  end
end

