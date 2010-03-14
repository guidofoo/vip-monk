class CreateCalifications < Sequel::Migration

  def up
    create_table :califications do
     primary_key :id
     foreign_key :customer_id, :customers
     foreign_key :item_id, :items
     String :texto_calif, :text=>true
     Numeric :value_calif
     Time :fecha
    end
  end

  def down
    drop_table :califications
  end
end
