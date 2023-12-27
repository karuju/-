require "test_helper"

class NovelsControllerTest < ActionDispatch::IntegrationTest
  test "should get scaffold" do
    get novels_scaffold_url
    assert_response :success
  end
end
