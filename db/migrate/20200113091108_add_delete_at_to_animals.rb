class AddDeleteAtToAnimals < ActiveRecord::Migration[6.0]
  def change
    add_column :animals, :deleted_at, :datetime
    add_index :animals, :deleted_at
  end
end
