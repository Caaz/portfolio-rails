require "test_helper"

class ContactRequestsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @contact_request = contact_requests(:one)
  end

  test "should get index" do
    sign_in admins(:one), scope: :admin
    get contact_requests_url
    assert_response :success
  end

  test "should get new" do
    get new_contact_request_url
    assert_response :success
  end

  test "should create contact_request" do
    stub_request(:post, /discord/)
    assert_difference("ContactRequest.count") do
      post contact_requests_url, params: { contact_request: { email: @contact_request.email, message: @contact_request.message, name: @contact_request.name, phone: @contact_request.phone } }
    end
    assert_requested :post, /discord/, times: 1
    assert_redirected_to new_contact_request_url
  end

  test "should show contact_request" do
    get contact_request_url(@contact_request)
    assert_response :success
  end

  test "should get edit" do
    sign_in admins(:one), scope: :admin
    get edit_contact_request_url(@contact_request)
    assert_response :success
  end

  test "should update contact_request" do
    sign_in admins(:one), scope: :admin
    patch contact_request_url(@contact_request), params: { contact_request: { email: @contact_request.email, message: @contact_request.message, name: @contact_request.name, phone: @contact_request.phone } }
    assert_redirected_to contact_request_url(@contact_request)
  end

  test "should destroy contact_request" do
    sign_in admins(:one), scope: :admin
    assert_difference("ContactRequest.count", -1) do
      delete contact_request_url(@contact_request)
    end

    assert_redirected_to contact_requests_url
  end
end
