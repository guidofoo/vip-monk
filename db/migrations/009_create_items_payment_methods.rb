class CreateItemsPaymentMethods < Sequel::Migration

  def up
    create_table :items_payment_methods do
      foreign_key :item_id, :items
      foreign_key :payment_method_id, :payment_methods
    end
  end

  def down
    drop_table :items_payment_methods
  end
end
