require 'test_helper'

class CinemasControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get cinemas_index_url
    assert_response :success
  end

  test "should get show" do
    get cinemas_show_url
    assert_response :success
  end

end
