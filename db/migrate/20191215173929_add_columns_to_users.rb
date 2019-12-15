class AddColumnsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :name, :string, null: false
    add_column :users, :is_sender, :boolean, default: false
    add_column :users, :sender_tel, :string, null: false, unique: true
    add_column :users, :sender_add, :string, null: false, unique: true
    add_column :users, :available_time, :text
  end
end
