class CreateItems < Sequel::Migration
  def up
    create_table :items do
      primary_key :id
      varchar     :title
    end
  end

  def down
    drop_table :items
  end
end
