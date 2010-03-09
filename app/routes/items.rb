class Main
  get "/items/:id" do
    @item = nil

    haml :"items/show"
  end
end
