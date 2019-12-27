class ChangeAvailableTimeOfUser < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :available_time, :text
    add_column :users, :available_time, :jsonb, :null => false, :default => {}
    add_index  :users, :available_time, using: :gin
  end
end
