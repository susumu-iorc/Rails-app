class CreateBases < ActiveRecord::Migration[6.0]
  def change
    create_table :bases do |t|
      t.integer :user_id
      t.text :user_address

      t.timestamps
    end
  end
end
