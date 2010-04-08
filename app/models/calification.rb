class Calification < Ohm::Model
  attribute :texto_calif
  attribute :value_calif
  attribute :fecha
end

require "app/models/customer"
require "app/models/item"

Calification.reference :customer, Customer
Calification.reference :item, Item
