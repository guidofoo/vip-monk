class Main

  before do
    @stamp = Time.new
  end

  get "/items" do
    @items = Item.all

    haml :"items/index", :layout => false
  end

  get "/items/:id.xml" do
    @item = Item[params[:id].to_i]
    content_type 'text/xml', :charset => 'utf-8'
    @item.to_xml.target!
  end

  get "/items/:id.json" do
    @item = Item[params[:id].to_i]
    content_type 'application/json', :charset => 'utf-8'
    @item.to_json
  end

  get "/items/:id" do
    @item = Item[params[:id].to_i]
    @pageTitle = @item.title
    @customer = @item.customer
    @questions = @item.questions
    @califications = @item.califications
    @shipMethods = @item.ship_methods
    @paymentMethods = @item.payment_methods

    @categories = Array.new
    category = @item.category
    while (!category.nil?)
      @categories.insert(0,category)
      category = category.category
    end

    @product = @item.catalog_product
    @product.calculate_reviews_summary
    @reviews = @product.reviews

    @catalogProductAttrs = @product.catalog_product_attributes

    @items_seller = @item.items_seller

     haml :"items/show"
  end

  # show the nickname if user has logged in ML
  get "/user" do
    @cookie = request.cookies["orgnickp"]

    haml :"items/user", layout: false
  end

  15.times do |i|
    7.times do |j|
      get "/resources#{i}/action#{j}" do
      end
    end
  end
end
