class Customer < Ohm::Model
  # set_dataset dataset.sequence(:seq_customers_id)
  attribute :nickname
  attribute :email
  attribute :points
  attribute :qty_calif
  
  collection :items, Item
  collection :califications, Calification

  def validate
    error.add(:nickname, :not_present) if nickname.nil?
    error.add(:email, :not_present) if email.nil?
  end
end
