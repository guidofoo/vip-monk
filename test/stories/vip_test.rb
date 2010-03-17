require "stories_helper"
require "webrat"

class VIPTest < Test::Unit::TestCase
  def assert_contain_in_scope(scope, text)
    assert contain(text.to_s).matches?(scope)
  end

  setup do
    Item.delete
    Customer.delete
    ShipMethod.delete
    PaymentMethod.delete
    CatalogProduct.delete
    CatalogProductAttribute.delete
    Review.delete
    Question.delete
    Calification.delete
  end

  feature "View item page" do
    setup do
      @item = Item.create title: "iPod touch 32gb 3ra generacion, caja sellada", price: 100, description: "description", image: "image.jpg", bids_count: 35
      @customer = Customer.create nickname: "MatataNoExiste", points: 95, qty_calif: 100
      @shipMethod = ShipMethod.create description: "A convenir"
      @paymentMethod = PaymentMethod.create name: "visa", logo: "sarasa"
      @product = CatalogProduct.create name: "Iphone mejor del mundo"
      @attr = CatalogProductAttribute.create key: "MyKey", value: "MyValue"
      @product.catalog_product_attributes << @attr
      @review = Review.create title: "Titulo de review", pros: "prossss", contras: "contrass", customer: @customer, catalog_product: @product, qty_votes: 10, qty_pos: 5, points: 4, conclusion: "conclusion"
      @product.save
      @question = Question.create item_id: @item.id, question: "pregunta loca", question_dt: Time.now, answer: "respuesta mas loca", answer_dt: Time.now
      @calification = Calification.create customer_id: @customer.id, item_id: @item.id, texto_calif: "todo barbaro", value_calif: 1, fecha: Time.now

      @item.catalog_product = @product
      @item.payment_methods << @paymentMethod
      @item.ship_methods << @shipMethod
      @item.customer = @customer
      @item.save
    end

    scenario "A user visiting the page should see the title" do
      visit "/items/#{@item.id}"

      assert_contain "iPod touch 32gb 3ra generacion, caja sellada"
    end

    scenario "A user visiting the page should see item price" do
      visit "/items/#{@item.id}"

      within ".price" do |scope|
        assert_contain_in_scope scope, @item.price
      end
    end

    scenario "A user visiting the page should see the description" do
      visit "/items/#{@item.id}"

      within "#descriptionCont" do |scope|
        assert_contain_in_scope scope, @item.description
      end
    end

    scenario "A user visiting the page should see the bids quantity" do
      visit "/items/#{@item.id}"

      within ".datavend" do |scope|
        assert_contain_in_scope scope, @item.bids_count.to_i
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
      # within "#linkMainImg" do |scope|
      #  58         assert_contain @item.image
      # end
     # end
   end
end


