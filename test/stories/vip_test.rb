require "stories_helper"
require "webrat"

class VIPTest < Test::Unit::TestCase
  feature "View item page" do
    setup do
      @item = Item.create title: "iPod touch 32gb 3ra generacion, caja sellada", price: 100, description: "description", qty_bids: 35
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

    scenario "A user visiting the page should see the bids quantity" do
        visit "/items/#{@item.id}"

        within ".datavend" do
          assert_contain @item.qty_bids.to_i.to_s
        end
    end

  end
end
