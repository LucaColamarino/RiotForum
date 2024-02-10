require "test_helper"

class NewpostControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get newpost_index_url
    assert_response :success
  end
end
