class AddItemsToCollections < ActiveRecord::Migration
  def change
    add_column :collections, :item_ids, :integer
  end
end
