class Customer < Sequel::Model
  # set_dataset dataset.sequence(:seq_customers_id)
  one_to_many :items
end
