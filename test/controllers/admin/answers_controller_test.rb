require "test_helper"

class Admin::AnswersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get admin_answers_show_url
    assert_response :success
  end

  test "should get edit" do
    get admin_answers_edit_url
    assert_response :success
  end

  test "should get update" do
    get admin_answers_update_url
    assert_response :success
  end

  test "should get destroy" do
    get admin_answers_destroy_url
    assert_response :success
  end
end
