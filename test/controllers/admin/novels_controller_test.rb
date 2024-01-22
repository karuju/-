require "test_helper"

class Admin::NovelsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get admin_novels_show_url
    assert_response :success
  end

  test "should get edit" do
    get admin_novels_edit_url
    assert_response :success
  end

  test "should get update" do
    get admin_novels_update_url
    assert_response :success
  end

  test "should get destroy" do
    get admin_novels_destroy_url
    assert_response :success
  end
end
