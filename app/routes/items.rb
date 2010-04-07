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

    @categories = Array.new
    category = @item.category
    while (!category.nil?)
      @categories.insert(0,category)
      category = category.category
    end

    haml :"items/show"
  end

  get "/items/:id/buy" do
    require_login
    @item = Item[params[:id].to_i]
    @user = session[:user]

    haml :"items/buy", layout: false
  end

  15.times do |i|
    7.times do |j|
      get "/resources#{i}/action#{j}" do
      end
    end
  end

end
