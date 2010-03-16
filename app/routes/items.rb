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

    @categories = Array.new
    category = @item.category
    while (!category.nil?)
      @categories.insert(0,category)
      category = category.category
    end

    @product = @item.catalog_product

    @catalogProductAttrs = @product.catalog_product_attributes
    # @paymentMethods = @item.payment_methods

    @items_seller = @item.items_seller

    haml :"items/show"
  end

end
