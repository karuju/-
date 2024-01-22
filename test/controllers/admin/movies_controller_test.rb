require "test_helper"

class Admin::MoviesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get admin_movies_show_url
    assert_response :success
  end

  test "should get edit" do
    get admin_movies_edit_url
    assert_response :success
  end

  test "should get update" do
    get admin_movies_update_url
    assert_response :success
  end

  test "should get destroy" do
    get admin_movies_destroy_url
    assert_response :success
  end
end
