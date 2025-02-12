class AddOmniauthToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :provider, :string, null: false
    add_column :users, :uid, :string, null: false
    add_column :users, :name, :string
    add_column :users, :email, :string, null: false
    add_index :users, [ :provider, :uid ], unique: true
    add_index :users, :email, unique: true
  end
end
