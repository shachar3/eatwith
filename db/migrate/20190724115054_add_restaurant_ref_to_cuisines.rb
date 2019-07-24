class AddRestaurantRefToCuisines < ActiveRecord::Migration[5.1]
  def change
    add_reference :cuisines, :restaurant, foreign_key: true
  end
end
