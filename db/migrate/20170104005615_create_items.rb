class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.string :title
      t.text :description
      t.integer :price_in_cents
      t.text :image_url
      t.references :category

      t.timestamps
    end
    add_index :items, :title, unique: true
    add_index :items, :image_url, unique: true
  end
end
