class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :img_url
      t.string :name
      t.string :condition
      t.integer :collection_id
      t.timestamps null: false
    end
  end
end
