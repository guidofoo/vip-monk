class Site < Sequel::Model
  one_to_many :items

  def validate
    errors.add(:site_id, :not_present) if site_id.nil?
    errors.add(:locale, :not_present) if locale.nil?
  end
end
