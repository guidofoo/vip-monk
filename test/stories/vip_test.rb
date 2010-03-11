require "stories_helper"
require "webrat"

class VIPTest < Test::Unit::TestCase
  feature "View item page" do
    setup do
      @item = Item.create title: "iPod touch 32gb 3ra generacion, caja sellada", price: 100, description: "description", image: "image.jpg"
    end

    scenario "A user visiting the page should see the title" do
      visit "/items/#{@item.id}"

      assert_contain "iPod touch 32gb 3ra generacion, caja sellada"
    end

    scenario "A user visiting the page should see item price" do
      visit "/items/#{@item.id}"

      within ".price" do
        assert_contain @item.price.to_i.to_s
      end
    end

    scenario "A user visiting the page should see the description" do
      visit "/items/#{@item.id}"

      within "#descriptionCont" do
        assert_contain @item.description
      end
    end

    scenario "A user visiting the page should see an image" do
      visit "/items/#{@item.id}"

      within "#linkMainImg" do
        assert_contain @item.image
      end
    end
  end
end
