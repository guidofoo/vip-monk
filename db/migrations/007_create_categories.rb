class CreateCategories < Sequel::Migration

  def up
    create_table :categories do
      primary_key :id
      String :name
      foreign_key :category_id, :categories
      TrueClass :accept_items
    end
  end

  def down
    drop_table :categories
  end
end
