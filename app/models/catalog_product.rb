class CatalogProduct < Sequel::Model
  one_to_many :items
  one_to_many :catalog_product_attributes
  one_to_many :reviews
end
