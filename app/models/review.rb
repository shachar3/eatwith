# == Schema Information
#
# Table name: reviews
#
#  id            :integer          not null, primary key
#  name          :string
#  rating        :integer
#  comment       :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  restaurant_id :integer
#

class Review < ApplicationRecord
  belongs_to :restaurant
end
