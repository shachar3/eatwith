class CreateOrderProcessings < ActiveRecord::Migration[5.1]
  def change
    create_table :order_processings do |t|
      t.uuid :order_id
      t.string :customer_name
      t.datetime :time
      t.datetime :publish_time
      t.string :status
      t.string :cook
      t.string :courier
      t.string :signed_by
      t.string :string

      t.timestamps
    end
  end
end
