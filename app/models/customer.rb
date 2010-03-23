class Customer < Sequel::Model
  # set_dataset dataset.sequence(:seq_customers_id)
  one_to_many :items
  one_to_many :califications

  def validate
    error.add(:nickname, :not_present) if nickname.nil?
    error.add(:email, :not_present) if email.nil?
  end
end
