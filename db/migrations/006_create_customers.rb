class CreateItems < Sequel::Migration
  def up
    create_table :customers do
      primary_key :id
      varchar     :nickname
      number      :points
      number      :qty_total
    end
  end

  def down
    drop_table :customers
  end
end
