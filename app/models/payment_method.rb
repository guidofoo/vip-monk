class PaymentMethod < Ohm::Model
  attribute :name
  attribute :logo
  
  collection :items, Item
  
end
