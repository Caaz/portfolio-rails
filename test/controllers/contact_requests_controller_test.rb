require "test_helper"

class ContactRequestsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @contact = contact_requests(:one)
    @contact_failure_email = contact_requests(:failure_email)
  end

  test "should get index" do
    sign_in admins(:one), scope: :admin
    get contact_requests_url
    assert_response :success
  end

  test "should create contact" do
    stub_request(:post, /discord/)
    assert_difference("ContactRequest.count") do
      post root_url, params: { contact_request: { email: @contact.email, message: @contact.message, name: @contact.name } }
    end
    assert_requested :post, /discord/, times: 1
    assert_redirected_to root_url
  end

  test "should fail contact" do
    stub_request(:post, /discord/)
    assert_no_difference("ContactRequest.count") do
      post root_url, params: { contact_request: { email: @contact_failure_email.email, message: @contact_failure_email.message, name: @contact_failure_email.name} }
    end
    assert_not_requested :post, /discord/
    assert_response :unprocessable_entity
  end

  test "should destroy contact" do
    sign_in admins(:one), scope: :admin
    assert_difference("ContactRequest.count", -1) do
      delete contact_request_url(@contact)
    end
    assert_redirected_to contact_requests_url
  end
end
