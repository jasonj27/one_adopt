class AddStatusToAnimals < ActiveRecord::Migration[6.0]
  def change
    add_column :animals, :adopt_status, :integer
    remove_column :animals, :is_searchable, :boolean
  end
end
