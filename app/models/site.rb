class Site < Ohm::Model
  extend Spawn

  attribute :site_id
  attribute :locale

  collection :items, Item

  def validate
    errors.add(:site_id, :not_present) if site_id.nil?
    errors.add(:locale, :not_present) if locale.nil?
  end
end

Site.spawner do |site|
  site.site_id = "MLA"
  site.locale = "es"
end
