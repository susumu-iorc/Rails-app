class CreateShops < ActiveRecord::Migration[6.0]
  def change
    create_table :shops do |t|
      t.string :place_id
      t.text :shop_address

      t.timestamps
    end
    add_index :shops, :place_id,  unique: true
  end
end
