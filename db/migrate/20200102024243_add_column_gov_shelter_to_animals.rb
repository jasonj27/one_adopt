class AddColumnGovShelterToAnimals < ActiveRecord::Migration[6.0]
  def change
    add_column :animals, :gov_shelter, :boolean, default: false
  end
end
