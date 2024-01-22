require "test_helper"

class Admin::ComicsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get admin_comics_show_url
    assert_response :success
  end

  test "should get edit" do
    get admin_comics_edit_url
    assert_response :success
  end

  test "should get update" do
    get admin_comics_update_url
    assert_response :success
  end

  test "should get destroy" do
    get admin_comics_destroy_url
    assert_response :success
  end
end
