require 'json'
require 'builder'
require 'slug'
require 'app/models/ship_method'
require 'app/models/question'

class Item < Ohm::Model
    include Slug

  attribute :title
  attribute :price
  attribute :bids_count
  attribute :description
  attribute :image

  reference :customer, Customer
  reference :site, Site
  reference :category, Category
  reference :catalog_product, CatalogProduct
  # many_to_one :customer
  # many_to_one :site
  # many_to_one :category
  # many_to_one :catalog_product

  # collection :questions, Question
  # collection :califications, Calification

  # one_to_many :questions
  # one_to_many :califications

  collection :califications, Calification
  collection :questions, Question

  # collection :questions do Question end
  # collection :questions, %s(Question)
  # collection :questions, -> (a, b) { Question }

  set :payment_methods, PaymentMethod
  set :ship_methods, ShipMethod

  # many_to_many :payment_methods
  # many_to_many :ship_methods

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
      to_hash.each do |name, val|
        meth = name.to_sym
        item.send(meth, send(meth))
      end
    end
    xml
  end

  def to_s
    title
  end

  # Trae los demas items de un customer
  def items_seller
    Item.find(customer_id: customer_id)
  end

  def questions
    Question.find(:item_id => self.id).sort(limit: 30)
  end

  # def price
    # super.to_f
  # end

  def validate
    assert_present :title
    assert_present :site_id
    assert_present :bids_count
    # errors.add(:title, :not_present) if title.nil?
    # errors.add(:site_id, :not_present) if site_id.nil?
    # errors.add(:bids_count, :not_present) if bids_count.nil?
  end
end
