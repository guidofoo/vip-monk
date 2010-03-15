class Question < Sequel::Model
  many_to_one :item
end
