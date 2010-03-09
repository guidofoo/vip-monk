require "stories_helper"

class VIPTest < Test::Unit::TestCase
  story "VIP" do
    scenario "Un usuario ingresa y ve el título" do
      visit "/items/1"

      assert_contain "Mouse usado"
    end
  end
end
