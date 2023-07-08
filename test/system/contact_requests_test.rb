require "application_system_test_case"

class ContactRequestsTest < ApplicationSystemTestCase
  setup do
    @contact_request = contact_requests(:one)
  end

  test "visiting the index" do
    visit contact_requests_url
    assert_selector "h1", text: "Contact requests"
  end

  test "should create contact request" do
    visit contact_requests_url
    click_on "New contact request"

    fill_in "Email", with: @contact_request.email
    fill_in "Message", with: @contact_request.message
    fill_in "Name", with: @contact_request.name
    fill_in "Phone", with: @contact_request.phone
    click_on "Create Contact request"

    assert_text "Contact request was successfully created"
    click_on "Back"
  end

  test "should update Contact request" do
    visit contact_request_url(@contact_request)
    click_on "Edit this contact request", match: :first

    fill_in "Email", with: @contact_request.email
    fill_in "Message", with: @contact_request.message
    fill_in "Name", with: @contact_request.name
    fill_in "Phone", with: @contact_request.phone
    click_on "Update Contact request"

    assert_text "Contact request was successfully updated"
    click_on "Back"
  end

  test "should destroy Contact request" do
    visit contact_request_url(@contact_request)
    click_on "Destroy this contact request", match: :first

    assert_text "Contact request was successfully destroyed"
  end
end
