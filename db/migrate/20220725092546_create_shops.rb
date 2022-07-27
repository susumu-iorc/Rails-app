class CreateShops < ActiveRecord::Migration[6.0]
  def change
    create_table :shops do |t|
      t.string :place_id
      t.text :shop_name
      t.text :shop_address
      t.decimal :lat,  precision: 10, scale: 7
      t.decimal :lng, precision: 10, scale: 7
      t.timestamps
    end
    add_index :shops, :place_id,  unique: true
  end
end
