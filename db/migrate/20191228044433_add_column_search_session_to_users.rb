class AddColumnSearchSessionToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :search_session, :text, array: true, default: []
  end
end
