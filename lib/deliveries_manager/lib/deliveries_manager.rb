# frozen_string_literal: true

require 'deliveries_manager/engine'

module DeliveriesManager
  def self.processPayload(payload)
    orderPayload = JSON.parse(payload)

    if (!OrderProcessing.exists?(:order_id => orderPayload["order_id"]))
      savedOP = OrderProcessing.new(orderPayload)
      savedOP.save()
    else
      savedOP = OrderProcessing.where(:order_id => orderPayload["order_id"]).first(1)[0]
      if savedOP.publish_time <= orderPayload["publish_time"]
        savedOP.publish_time = orderPayload["publish_time"]
        savedOP.status = orderPayload["status"]
        savedOP.cook = orderPayload["cook"] if !orderPayload["cook"].nil?
        savedOP.courier = orderPayload["courier"] if !orderPayload["courier"].nil?
        savedOP.signed_by = orderPayload["signed_by"] if !orderPayload["signed_by"].nil?
        savedOP.time = orderPayload["time"]
        savedOP.status = orderPayload["status"]
      end
    end
    savedOP.save()
  end
end
