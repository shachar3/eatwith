class RestaurantsController < ApplicationController
  def index
    restuarants = Restaurant.all
    render json: restuarants
  end
end
