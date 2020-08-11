class AddLastLoginToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :last_login, :date
    add_column :users, :role, :string, null:false, default: 'user'
  end
end
