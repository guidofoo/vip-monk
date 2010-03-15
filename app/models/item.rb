class Item < Sequel::Model
  set_dataset dataset.sequence(:seq_items_id)
  many_to_one :customer
end
