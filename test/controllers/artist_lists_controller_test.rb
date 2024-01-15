require "test_helper"

class ArtistListsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get artist_lists_index_url
    assert_response :success
  end

  test "should get create" do
    get artist_lists_create_url
    assert_response :success
  end

  test "should get destroy" do
    get artist_lists_destroy_url
    assert_response :success
  end
end
