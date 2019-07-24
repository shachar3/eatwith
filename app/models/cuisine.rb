# == Schema Information
#
# Table name: cuisines
#
#  id            :integer          not null, primary key
#  name          :string
#  icon          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  restaurant_id :integer
#

class Cuisine < ApplicationRecord
end
