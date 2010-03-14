class CreatePaymentMethods < Sequel::Migration

  def up
    create_table :payment_methods do
      primary_key :id
      String :name
      String :logo
    end
  end

  def down
    drop_table :payment_methods
  end
end
