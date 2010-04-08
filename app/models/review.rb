class Review < Ohm::Model
  attribute :title
  attribute :points
  attribute :pros
  attribute :contras
  attribute :conclusion
  attribute :qty_pos
  attribute :qty_votes

  reference :customer, lambda { |id| Customer[id] }
  reference :catalog_product, lambda { |id| CatalogProduct[id] }
end
