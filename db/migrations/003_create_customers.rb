class CreateCustomers < Sequel::Migration

  def up
    create_table :customers do
      primary_key :id
      String :nickname
      Numeric :points
      Numeric :qty_calif
    end
  end

  def down
    drop_table :customers
  end
end
