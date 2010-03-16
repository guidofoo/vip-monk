class Review < Sequel::Model
  many_to_one :customer
  many_to_one :catalog_product
end
