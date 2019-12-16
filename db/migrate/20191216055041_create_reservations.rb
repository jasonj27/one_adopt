class CreateReservations < ActiveRecord::Migration[6.0]
  def change
    create_table :reservations do |t|
      t.integer :status
      t.datetime :datetime
      t.text :note
      t.date :success_time
      t.references :sender, null: false
      t.references :receiver, null: false

      t.timestamps
    end
  end
end
