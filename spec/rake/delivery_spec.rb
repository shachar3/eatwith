require 'deliveries_manager'

RSpec.describe DeliveriesManager do
  it 'should save order to db' do
    payload = "{\"order_id\":\"5db2ca7f-9366-49f2-b0a6-785bc1ecee5e\",\"customer_name\":\"nn\",\"time\":\"2019-08-04T20:20:59+00:00\",\"publish_time\":\"2019-08-04T20:20:59+00:00\",\"status\":\"Received\"}"
    DeliveriesManager.processPayload(payload)
    expect(OrderProcessing.where(:order_id => '5db2ca7f-9366-49f2-b0a6-785bc1ecee5e').count).to eq(1)
  end

  it 'should update order status' do
    payload = "{\"order_id\":\"5db2ca7f-9366-49f2-b0a6-785bc1ecee5e\",\"customer_name\":\"nn\",\"time\":\"2019-08-04T20:20:59+00:00\",\"publish_time\":\"2019-08-04T20:20:59+00:00\",\"status\":\"Received\"}"
    DeliveriesManager.processPayload(payload)
    expect(OrderProcessing.where(:order_id => '5db2ca7f-9366-49f2-b0a6-785bc1ecee5e').pluck(:status)[0]).to eq("Received")
    payload = "{\"order_id\":\"5db2ca7f-9366-49f2-b0a6-785bc1ecee5e\",\"customer_name\":\"nn\",\"time\":\"2019-08-04T20:21:59+00:00\",\"publish_time\":\"2019-08-04T20:21:59+00:00\",\"status\":\"Delivered\"}"
    DeliveriesManager.processPayload(payload)
    expect(OrderProcessing.where(:order_id => '5db2ca7f-9366-49f2-b0a6-785bc1ecee5e').pluck(:status)[0]).to eq("Delivered")
  end

  it 'should NOT update order status' do
    payload = "{\"order_id\":\"5db2ca7f-9366-49f2-b0a6-785bc1ecee5F\",\"customer_name\":\"nn\",\"time\":\"2019-08-04T20:20:59+00:00\",\"publish_time\":\"2019-08-04T20:20:59+00:00\",\"status\":\"Received\"}"
    DeliveriesManager.processPayload(payload)
    expect(OrderProcessing.where(:order_id => '5db2ca7f-9366-49f2-b0a6-785bc1ecee5F').pluck(:status)[0]).to eq("Received")
    payload = "{\"order_id\":\"5db2ca7f-9366-49f2-b0a6-785bc1ecee5F\",\"customer_name\":\"nn\",\"time\":\"2018-08-04T20:21:59+00:00\",\"publish_time\":\"2018-08-04T20:21:59+00:00\",\"status\":\"Delivered\"}"
    DeliveriesManager.processPayload(payload)
    expect(OrderProcessing.where(:order_id => '5db2ca7f-9366-49f2-b0a6-785bc1ecee5F').pluck(:status)[0]).to eq("Received")
  end
end
