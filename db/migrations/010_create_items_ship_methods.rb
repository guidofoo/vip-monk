class CreateItemsShipMethods < Sequel::Migration

  def up
    create_table :items_ship_methods do
      foreign_key :item_id, :items
      foreign_key :ship_method_id, :ship_methods
    end
  end

  def down
    drop_table :items_ship_methods
  end
end
