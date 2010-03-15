class CreateItems < Sequel::Migration
  def up
    alter_table :items do
      add_column :customer_id, :number
    end
  end

  def down
    alter_table :items do
      drop_column :customer_id
    end
  end
end

