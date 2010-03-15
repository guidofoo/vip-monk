class PaymentMethod < Sequel::Model
  many_to_many :items
end
