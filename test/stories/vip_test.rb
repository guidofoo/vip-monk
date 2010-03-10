require "stories_helper"

class VIPTest < Test::Unit::TestCase
  setup do
    Item.delete
  end

  feature "View item page" do
    setup do
      @item = Item.create title: "iPod touch 32gb 3ra generacion, caja sellada"
    end

    scenario "A user visiting the page should see the title" do
      visit "/items/#{@item.id}"

      assert_contain "iPod touch 32gb 3ra generacion, caja sellada"
    end
  end
end
