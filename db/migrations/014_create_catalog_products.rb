class CreateCatalogProducts < Sequel::Migration

  def up
    create_table :catalog_products do
      primary_key :id
      String :name
    end
  end

  def down
    drop_table :catalog_products
  end
end
