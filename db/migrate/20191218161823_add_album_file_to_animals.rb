class AddAlbumFileToAnimals < ActiveRecord::Migration[6.0]
  def change
    add_column :animals, :album_file, :string
  end
end
