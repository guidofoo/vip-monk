require 'json'
require 'builder'

class Item < Sequel::Model
 # set_dataset dataset.sequence(:seq_items_id)
  many_to_one :customer
  many_to_one :site
  many_to_one :category
  many_to_one :catalog_product

  one_to_many :questions
  one_to_many :califications


  many_to_many :payment_methods
  many_to_many :ship_methods


  def to_hash
    values
  end

  def to_json(*args)
    to_hash.to_json(*args)
  end

  def to_xml(options = {})
    xml = Builder::XmlMarkup.new( options )
    xml.instruct!
    xml.item do |item|
      values.each do |name, val|
        eval("item.#{name} val")
      end
    end
    xml
  end

  # Trae los demas items de un customer
  def items_seller
    Item.filter(:customer_id => self.customer_id).exclude(:id => self.id)
  end

  def questions
   Question.filter(:item_id => self.id).limit(30)
  end
end
