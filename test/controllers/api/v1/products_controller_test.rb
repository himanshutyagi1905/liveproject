require "test_helper"

class Api::V1::ProductsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get api_v1_products_create_url
    assert_response :success
  end
end
