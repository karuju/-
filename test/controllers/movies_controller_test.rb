require "test_helper"

class MoviesControllerTest < ActionDispatch::IntegrationTest
  test "should get scaffold" do
    get movies_scaffold_url
    assert_response :success
  end
end
