class Item < Sequel::Model
  many_to_one :customer
  many_to_one :site
  one_to_many :questions
  one_to_many :califications
end
