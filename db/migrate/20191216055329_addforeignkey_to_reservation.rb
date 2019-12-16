class AddforeignkeyToReservation < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :reservations, :users, column: :sender_id, primary_key: :id
    add_foreign_key :reservations, :users, column: :receiver_id, primary_key: :id
  end
end
