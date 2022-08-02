class CreateBases < ActiveRecord::Migration[6.0]
  def change
    create_table :bases do |t|
      t.integer :user_id
      t.text :user_address
      t.decimal :lat,  precision: 10, scale: 7
      t.decimal :lng, precision: 10, scale: 7
      t.timestamps
    end
  end
end
