class Main
  get "/items/:id" do
    @item = Item[params[:id]]

    haml :"items/show"
  end
end
