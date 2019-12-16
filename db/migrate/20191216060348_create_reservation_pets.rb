class CreateReservationPets < ActiveRecord::Migration[6.0]
  def change
    create_table :reservation_pets do |t|
      t.references :animal, null: false, foreign_key: true
      t.references :reservation, null: false, foreign_key: true

      t.timestamps
    end
  end
end
