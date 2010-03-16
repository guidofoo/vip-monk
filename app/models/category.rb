class Category < Sequel::Model
  many_to_one :category
  one_to_many :items
  one_to_many :categories
end
