require "stories_helper"
require "webrat"

class VIPTest < Test::Unit::TestCase
  def assert_contain_in_scope(scope, text)
    assert contain(text.to_s).matches?(scope)
  end

  setup do
    Ohm.flush
  end

  feature "View item page" do
    setup do
      @site = Site.create site_id: "MLA", locale: "es"
      @item = Item.create title: "iPod touch 32gb 3ra generacion, caja sellada", price: 100, description: "description", image: "image.jpg", bids_count: 35, site: @site
      @customer = Customer.create nickname: "MatataNoExiste", points: 95, qty_calif: 100, email: "mail@prueba.com"
      @shipMethod = ShipMethod.create description: "A convenir"
      @paymentMethod = PaymentMethod.create name: "visa", logo: "sarasa"
      @product = CatalogProduct.create name: "Iphone mejor del mundo"
      @attr = CatalogProductAttribute.create clave: "Myclave", valor: "MyValue", catalog_product: @product
      # @product.add_catalog_product_attribute(@attr)
      @review = Review.create title: "Titulo de review", pros: "prossss", contras: "contrass", customer: @customer, catalog_product: @product, qty_votes: 10, qty_pos: 5, points: 4, conclusion: "conclusion"
      @product.save
      @question = Question.create item_id: @item.id, question: "pregunta para test", question_dt: Time.now, answer: "respuesta para test", answer_dt: Time.now
      @calification = Calification.create customer_id: @customer.id, item_id: @item.id, texto_calif: "todo barbaro", value_calif: 1, fecha: Time.now

      @item.catalog_product = @product
      @item.payment_methods.add(@paymentMethod)
      @item.ship_methods.add(@shipMethod)
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
        assert_contain_in_scope scope, @item.price.to_i
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

    scenario "A user visiting the page should see ship methods" do
      visit "/items/#{@item.id}"

      within "#shipMethodDesc" do |scope|
        assert_contain_in_scope scope, @item.ship_methods.first.description
      end
    end

    scenario "A user visiting the page should see payment methods" do
      visit "/items/#{@item.id}"

      within "#paymentMethodName" do |scope|
        assert_contain_in_scope scope, @item.payment_methods.first.name
      end
    end

    scenario "A user visiting the page should see a question" do
     visit "/items/#{@item.id}"

     within "#bigQues" do |scope|
       assert_contain_in_scope scope, @item.questions.first.question
     end
    end

    scenario "A user visiting the page should see an answer" do
     visit "/items/#{@item.id}"

     within "#bigQues" do |scope|
       assert_contain_in_scope scope, @item.questions.first.answer
     end
    end

    scenario "A user visiting the page should see a buyer calification" do
      visit "/items/#{@item.id}"

      within ".bloque-cal" do |scope|
        assert_contain_in_scope scope, @item.califications.first.texto_calif
      end
    end

    scenario "A user visting the page should see the product specifications" do
      visit "/items/#{@item.id}"

      within "#attr" do |scope|
        assert_contain_in_scope scope, @item.catalog_product.catalog_product_attributes.first.clave
      end

      within "#attr" do |scope|
        assert_contain_in_scope scope, @item.catalog_product.catalog_product_attributes.first.valor
      end
    end

    scenario "A user visting the page should see product reviews" do
      visit "/items/#{@item.id}"

      within ".optitle" do |scope|
        assert_contain_in_scope scope, @item.catalog_product.reviews.first.title
      end

      within ".autor_rev_link" do |scope|
        assert_contain_in_scope scope, @item.catalog_product.reviews.first.customer.nickname
      end

      within ".autor_rev_link" do |scope|
        assert_contain_in_scope scope, @item.catalog_product.reviews.first.customer.points.to_i.to_s
      end

      within ".pros" do |scope|
        assert_contain_in_scope scope, @item.catalog_product.reviews.first.pros
      end

      within ".contras" do |scope|
        assert_contain_in_scope scope, @item.catalog_product.reviews.first.contras
      end

      within ".opconcl" do |scope|
        assert_contain_in_scope scope, @item.catalog_product.reviews.first.conclusion
      end
    end

  end
end
