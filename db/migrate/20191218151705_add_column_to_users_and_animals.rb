class AddColumnToUsersAndAnimals < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :animal_shelter_pkid, :integer
    add_column :animals, :animal_shelter_pkid, :integer
  end
end
