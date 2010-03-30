require "test_helper"

class TestItem < Test::Unit::TestCase

  setup do
    @site = Site.create site_id: "MLA", locale: "es"
    @item = Item.create price: 100, title: "titulo", description: "description", image: "image.jpg", bids_count: 35, site: @site
  end

  should "validate presence of title" do
    @item.update(title: nil)

    assert_equal [:not_present], @item.errors.on(:title)
  end

  should "validate presence of site_id" do
    @item.update(site_id: nil)

    assert_equal [:not_present], @item.errors.on(:site_id)
  end

  should "validate presence of bids count" do
    @item.update(bids_count: nil)

    assert_equal [:not_present], @item.errors.on(:bids_count)
  end

  teardown do
    Site.delete
    Item.delete
  end
end
