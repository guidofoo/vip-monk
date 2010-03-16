class Main

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
    @reviews = @product.reviews

    @catalogProductAttrs = @product.catalog_product_attributes

    @items_seller = @item.items_seller

    haml :"items/show"
  end

end
