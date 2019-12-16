class ChangeColumnOfUser < ActiveRecord::Migration[6.0]
  def change
    change_column_null :users, :sender_tel, true
    change_column_null :users, :sender_add, true
  end
end
