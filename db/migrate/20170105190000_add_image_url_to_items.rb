class AddImageUrlToItems < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :image_url, :text
  end
end
