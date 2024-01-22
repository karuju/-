require "test_helper"

class Admin::SongsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get admin_songs_show_url
    assert_response :success
  end

  test "should get edit" do
    get admin_songs_edit_url
    assert_response :success
  end

  test "should get update" do
    get admin_songs_update_url
    assert_response :success
  end

  test "should get destroy" do
    get admin_songs_destroy_url
    assert_response :success
  end
end
