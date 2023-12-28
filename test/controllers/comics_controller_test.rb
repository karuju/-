require "test_helper"

class ComicsControllerTest < ActionDispatch::IntegrationTest
  test "should get scaffold" do
    get comics_scaffold_url
    assert_response :success
  end
end
