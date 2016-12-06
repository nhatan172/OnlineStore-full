require 'test_helper'

class CartdetailsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get cartdetails_create_url
    assert_response :success
  end

end
