require "test_helper"

class Admin::AnimesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_animes_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_animes_show_url
    assert_response :success
  end

  test "should get edit" do
    get admin_animes_edit_url
    assert_response :success
  end

  test "should get update" do
    get admin_animes_update_url
    assert_response :success
  end

  test "should get destroy" do
    get admin_animes_destroy_url
    assert_response :success
  end
end
