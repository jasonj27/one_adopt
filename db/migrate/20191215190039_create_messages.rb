class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.references :from
      t.references :to
      t.text :content
      t.timestamps
    end
  end
end
