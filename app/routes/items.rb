class Main

  get "/items/:id.xml" do
    @item = Item[params[:id].to_i]
    content_type 'text/xml', :charset => 'utf-8'
    @item.to_xml
  end


  get "/items/:id" do
    @item = Item[params[:id].to_i]
    @customer = @item.customer

    haml :"items/show"
  end

end
