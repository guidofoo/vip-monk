class ShipMethod < Ohm::Model
  attribute :description
  collection :items, Item
end
