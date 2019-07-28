class CuisinesController < ApplicationController
    def index
        cuisines = Cuisine.all
        render json: cuisines.as_json(only: [:name, :icon])
    end
end
