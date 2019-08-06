# frozen_string_literal: true
require 'deliveries_manager'

namespace :delivery do
  desc 'listen to delivery creation commands'
  task subscribe: :environment do

    conn = Bunny.new(ENV['RABBIT_URL'])
    conn.start
    ch = conn.create_channel
    queue = ch.queue('delivery.status_updated', auto_delete: true)
    queue.subscribe(block: true) do |_, _, payload|
      byebug
      DeliveriesManager.processPayload(payload)
    end
  end
end

