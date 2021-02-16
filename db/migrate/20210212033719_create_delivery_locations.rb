class CreateDeliveryLocations < ActiveRecord::Migration[6.0]
  def change
    create_table :delivery_locations do |t|
      t.string :post_code   ,                null: true
      t.integer :region_id      ,            null: true
      t.string :city        ,                null: true
      t.string :address     ,                null: true
      t.string :building    
      t.string :phone_number,                null: true
      t.references :order,                foreign_key: true
      t.timestamps
    end
  end
end
