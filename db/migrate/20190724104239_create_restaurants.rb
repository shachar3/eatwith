class CreateRestaurants < ActiveRecord::Migration[5.1]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.boolean :accepts_10bis, default: true
      t.string :address
      t.integer :max_delivery_time, default: 60
      t.float :longitude
      t.float :latitude
      t.integer :zomato_id
      t.timestamps
    end
  end
end
