# == Schema Information
#
# Table name: restaurants
#
#  id                :integer          not null, primary key
#  name              :string
#  accepts_10_bis    :boolean
#  address           :string
#  max_delivery_time :integer
#  longitude         :float
#  latitude          :float
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Restaurant < ApplicationRecord
  has_many :reviews
  belongs_to :cuisine, optional: true

  def as_json(*)
    super.except('created_at', 'updated_at', 'longitude', 'latitude', 'zomato_id', 'cuisine_id').tap do |hash|
      hash['coordinates'] = { lat: latitude, lon: longitude }
      if !reviews.nil?
        hash['reviews'] = []
        reviews.each do |rev|
          hash['reviews'].push({ id: rev.id, name: rev.name, comment: rev.comment, rating: rev.rating })
        end
      end
      if !cuisine.nil?
        hash['cuisine'] = { name: cuisine.name, icon: cuisine.icon }
      end
    end
  end
end
