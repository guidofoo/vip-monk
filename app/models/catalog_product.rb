class CatalogProduct < Sequel::Model
  one_to_many :items
  one_to_many :catalog_product_attributes
  one_to_many :reviews


  def calculate_reviews_summary
  end

  def get_balls_image_link
  end
end
