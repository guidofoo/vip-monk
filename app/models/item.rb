require 'json'
require 'builder'

class Item < Sequel::Model
 # set_dataset dataset.sequence(:seq_items_id)
  many_to_one :customer
  many_to_one :site
  one_to_many :questions
  one_to_many :califications

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
end
