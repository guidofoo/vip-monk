class CreateShipMethods < Sequel::Migration

  def up
    create_table :ship_methods do
      primary_key :id
      String :description
    end
  end

  def down
    drop_table :ship_methods
  end

end
