class Customer < Sequel::Model
  one_to_many :item
end
