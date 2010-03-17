module Slug
  def to_param
    "#{super}-#{slug}"
  end

  def slug
    to_s.gsub("'", "").gsub(/\W/, " ").strip.gsub(/\s+/, "-").downcase
  end
end
