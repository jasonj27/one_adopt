class CreateAnimals < ActiveRecord::Migration[6.0]
  def change
    create_table :animals do |t|
      t.string :name
      t.string :animal_subid
      t.integer :animal_area_pkid
      t.integer :animal_kind
      t.integer :animal_sex
      t.integer :animal_age
      t.integer :animal_sterilization
      t.string :animal_foundplace
      t.boolean :is_searchable
      t.integer :animal_status
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
