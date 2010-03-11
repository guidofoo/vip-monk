class Main
  get "/items/:id" do
    @item = Item[params[:id].to_i]

    haml :"items/show"
  end
end
