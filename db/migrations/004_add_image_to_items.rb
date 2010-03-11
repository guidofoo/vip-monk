class AddImageToItems < Sequel::Migration
  def up
    alter_table :items do
      add_column :image, String
    end
  end

  def down
    alter_table :items do
      drop_column :image, String
    end
  end
end
