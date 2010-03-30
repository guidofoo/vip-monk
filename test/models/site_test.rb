require 'test_helper'

class TestSite < Test::Unit::TestCase
  setup do
    @site = Site.new site_id: "MLA", locale: "es"
  end

  should "validate presence of site id" do
    @site.update(site_id: nil)

    assert !@site.valid?
    assert_equal [:not_present], @site.errors.on(:site_id)
  end

  should "validate presence of locale" do
   @site.update(locale: nil)

    assert !@site.valid?
    assert_equal [:not_present], @site.errors.on(:locale)
  end

  teardown do
    Site.delete
  end
end
