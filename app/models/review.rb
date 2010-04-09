class Review < Ohm::Model
  attribute :title
  attribute :points
  attribute :pros
  attribute :contras
  attribute :conclusion
  attribute :qty_pos
  attribute :qty_votes

  reference :customer, Customer
  reference :catalog_product, CatalogProduct
end
