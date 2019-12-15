class AddforeignkeyToMessages < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :messages, :users, column: :from_id, primary_key: :id
    add_foreign_key :messages, :users, column: :to_id, primary_key: :id
  end
end
