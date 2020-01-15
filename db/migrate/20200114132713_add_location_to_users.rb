class AddLocationToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :latitude, :float
    add_column :users, :longitude, :float
    add_column :animals, :latitude, :float
    add_column :animals, :longitude, :float
  end
end
