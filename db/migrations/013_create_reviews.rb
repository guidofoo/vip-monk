class CreateReviews < Sequel::Migration

  def up
    create_table :reviews do
      primary_key :id
      String :title
      Numeric :points
      foreign_key :customer_id, :customers
      foreign_key :catalog_product_id, :catalog_products
      String :pros, :text=>true
      String :contras, :text=>true
      String :conclusion, :text=>true
      Numeric :qty_votes
      Numeric :qty_pos
    end
  end

  def down
    drop_table :reviews
  end
end
