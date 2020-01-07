class AddColumnAnimalBodytypeAndColourToAnimal < ActiveRecord::Migration[6.0]
  def change
    add_column :animals, :animal_bodytype, :integer
    add_column :animals, :animal_colour, :integer
  end
end
