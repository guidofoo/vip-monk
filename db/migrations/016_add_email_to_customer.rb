class AddEmailToCustomer < Sequel::Migration

  def up
    alter_table :customers do
      add_column :email, String
    end
  end

  def down
    alter_table :customers do
      drop_column :email
    end
  end

end
