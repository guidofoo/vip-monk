class CreateCatalogProductAttributes < Sequel::Migration
  def up
    create_table :catalog_product_attributes do
      primary_key :id
      String :key
      String :value
      foreign_key :catalog_product_id, :catalog_products
    end

  end

  def down
    drop_table :catalog_product_attributes
  end

end
