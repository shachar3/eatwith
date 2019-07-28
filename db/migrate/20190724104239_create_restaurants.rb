class CreateRestaurants < ActiveRecord::Migration[5.1]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.boolean :accepts_10bis
      t.string :address
      t.integer :max_delivery_time
      t.float :longitude
      t.float :latitude

      t.timestamps
    end
  end
end
