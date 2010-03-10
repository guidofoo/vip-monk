class AddPriceToItems < Sequel::Migration
  def up
    alter_table :items do
      add_column :price, :number
    end
#     add_column :items, :price, :numeric
  end

  def down
    alter_table :items do
      drop_column :price
    end
  end
end
