class AddColumnAnimalIdToAnimals < ActiveRecord::Migration[6.0]
  def change
    add_column :animals, :animal_id, :integer
  end
end
