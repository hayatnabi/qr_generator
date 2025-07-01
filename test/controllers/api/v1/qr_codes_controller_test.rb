require "test_helper"

class Api::V1::QrCodesControllerTest < ActionDispatch::IntegrationTest
  test "should get generate" do
    get api_v1_qr_codes_generate_url
    assert_response :success
  end
end
