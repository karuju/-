require "test_helper"

class AnimesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get animes_new_url
    assert_response :success
  end

  test "should get search" do
    get animes_search_url
    assert_response :success
  end

  test "should get show" do
    get animes_show_url
    assert_response :success
  end

  test "should get create" do
    get animes_create_url
    assert_response :success
  end
end
