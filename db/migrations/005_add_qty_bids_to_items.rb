class AddDescriptionToItems < Sequel::Migration
  def up
    alter_table :items do
      add_column :qty_bids, :number
    end
  end
  
  def down
    alter_table :items do
      drop_column :qty_bids
    end
  end
end
