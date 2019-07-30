class AddCuisineRefToRestaurants < ActiveRecord::Migration[5.1]
  def change
    add_reference :restaurants, :cuisine, foreign_key: true
  end
end
