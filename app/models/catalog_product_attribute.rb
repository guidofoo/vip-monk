class CatalogProductAttribute < Ohm::Model
  attribute :clave
  attribute :valor
  reference :catalog_product, lambda { |id| CatalogProduct[id] }
end
