class CreateSites < Sequel::Migration

  def up
    create_table :sites do
      primary_key :id
      String :site_id
      String :locale
    end
  end

  def down
    drop_table :sites 
  end
end
