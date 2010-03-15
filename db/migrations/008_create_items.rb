class CreateItems < Sequel::Migration

  def up
    create_table :items do
      primary_key :id
      foreign_key :site_id, :sites
      String :title
      String :image
      String :description, :text=>true
      Numeric :price
      Numeric :bids_count
      foreign_key :customer_id, :customers
      foreign_key :category_id, :categories
      foreign_key :catalog_product_id, :catalog_products
    end
  end

  def down
    drop_table :items
  end
end
