class AddDescriptionToItems < Sequel::Migration
  def up
    alter_table :items do
      add_column :description, String
    end
  end

  def down
    alter_table :items do
      drop_column :description
    end
  end
end
