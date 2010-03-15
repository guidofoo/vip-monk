require "stories_helper"
require "webrat"

class VIPTest < Test::Unit::TestCase
  def assert_contain_in_scope(scope, text)
    assert contain(text).matches?(scope)
  end

  setup do
    Item.delete
    Customer.delete
  end

  feature "View item page" do
    setup do
      @item = Item.create title: "iPod touch 32gb 3ra generacion, caja sellada", price: 100, description: "description", image: "image.jpg", qty_bids: 35
      @customer = Customer.create nickname: "MatataNoExiste", points: 95, qty_total: 100
      @item.customer = @customer
      @item.save
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

      within ".datavend" do |scope|
        assert_contain_in_scope scope, "Sells on this article"
        assert_contain_in_scope scope, "35"
      end
    end

    scenario "A user visiting the page should see seller info" do
      visit "/items/#{@item.id}"

      within "#MyNickname" do |scope|
        assert_contain_in_scope scope, @customer.nickname
      end

      within "#puntos" do |scope|
        assert_contain_in_scope scope, @customer.points.to_i.to_s
      end

    end


    # scenario "A user visiting the page should see the image" do
      # visit "/items/#{@item.id}"

      # within "#divMainImg" do
        # assert_contain @item.image
      # end
     # end
   end

end
