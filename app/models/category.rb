class Category < Ohm::Model
  attribute :name
  reference :category, Category
  collection :items, Item
  collection :categories, Category
end
