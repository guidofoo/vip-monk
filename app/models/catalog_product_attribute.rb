class CatalogProductAttribute < Sequel::Model
  many_to_one :catalog_product
end
