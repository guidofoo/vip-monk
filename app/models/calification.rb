class Calification < Sequel::Model
  many_to_one :customer
  many_to_one :item
end
