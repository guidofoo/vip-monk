class Monk < Thor
  include Thor::Actions

  desc "test", "Run all tests"
  def test
    verify_config(:test)

    $:.unshift File.join(File.dirname(__FILE__), "test")

    Dir['test/**/*_test.rb'].each do |file|
      load file unless file =~ /^-/
    end
  end

  desc "stories", "Run user stories."
  method_option :pdf, :type => :boolean
  def stories
    $:.unshift(Dir.pwd, "test")

    ARGV << "-r"
    ARGV << (options[:pdf] ? "stories-pdf" : "stories")
    ARGV.delete("--pdf")

    Dir["test/stories/*_test.rb"].each do |file|
      load file
    end
  end

  desc "start ENV", "Start Monk in the supplied environment"
  def start(env = ENV["RACK_ENV"] || "development")
    verify_config(env)

    exec "env RACK_ENV=#{env} ruby init.rb"
  end

  desc "copy_example EXAMPLE, TARGET", "Copies an example file to its destination"
  def copy_example(example, target = target_file_for(example))
    File.exists?(target) ? return : say_status(:missing, target)
    File.exists?(example) ? copy_file(example, target) : say_status(:missing, example)
  end

  desc "init", "Initialize the environment"
  def init
    require "init"
  end

  desc "migrate VERSION = latest", "Migrates the database"
  def migrate(version = nil)
    invoke :init

    require "sequel/extensions/migration"

    version = version.to_i if version

    puts "Migrating to version #{ version || "<latest>" }"

    Sequel::Migrator.apply(Sequel::Model.db, "db/migrations", version)
  end

  desc "seed", "Add seed data to the database"
  def seed
    invoke :init

    Item.delete
    Customer.delete
    ShipMethod.delete
    PaymentMethod.delete
    CatalogProduct.delete
    CatalogProductAttribute.delete
    Review.delete
    Question.delete
    Calification.delete

    #TODO add param
    1.times do
      @site = Site.create site_id: "MLA", locale: "es"
      @item = Item.create title: "iPod touch 32gb 3ra generacion, caja sellada", price: 100, description: "description", image: "image.jpg", bids_count: 35, site: @site
      @customer = Customer.create nickname: "MatataNoExiste", points: 95, qty_calif: 100, email: "customer@email.com"
      @shipMethod = ShipMethod.create description: "A convenir"
      @paymentMethod = PaymentMethod.create name: "visa", logo: "sarasa"
      @product = CatalogProduct.create name: "Iphone mejor del mundo"
      @attr = CatalogProductAttribute.create key: "MyKey", value: "MyValue"
      @product.add_catalog_product_attribute(@attr)
      @review = Review.create title: "Titulo de review", pros: "prossss", contras: "contrass", customer: @customer, catalog_product: @product, qty_votes: 10, qty_pos: 5, points: 4, conclusion: "conclusion"
      @product.save
      @question = Question.create item_id: @item.id, question: "pregunta loca", question_dt: Time.now, answer: "respuesta mas loca", answer_dt: Time.now
      @calification = Calification.create customer_id: @customer.id, item_id: @item.id, texto_calif: "todo barbaro", value_calif: 1, fecha: Time.now

      @item.catalog_product = @product
      @item.add_payment_method(@paymentMethod)
      @item.add_ship_method(@shipMethod)
      @item.customer = @customer
      @item.save
    end
  end

private

  def self.source_root
    File.dirname(__FILE__)
  end

  def target_file_for(example_file)
    example_file.sub(".example", "")
  end

  def verify_config(env)
    verify "config/settings.example.yml"
    verify "config/redis/#{env}.example.conf"
  end

  def verify(example)
    copy_example(example) unless File.exists?(target_file_for(example))
  end

end
