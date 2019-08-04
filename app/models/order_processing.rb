# == Schema Information
#
# Table name: order_processings
#
#  id            :integer          not null, primary key
#  order_id      :uuid
#  customer_name :string
#  time          :datetime
#  publish_time  :datetime
#  status        :string
#  cook          :string
#  courier       :string
#  signed_by     :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class OrderProcessing < ApplicationRecord
end
