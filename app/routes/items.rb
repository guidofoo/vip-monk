class Main
  get "/items/:id" do
    @item = Item.find(id: params[:id])

    haml :"items/show"
  end
end
