require "test_helper"

class LinksControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @link = links(:one)
  end

  test "should get index" do
    sign_in admins(:one), scope: :admin
    get links_url
    assert_response :success
  end

  test "should get new" do
    sign_in admins(:one), scope: :admin
    get new_link_url
    assert_response :success
  end

  test "should create link" do
    sign_in admins(:one), scope: :admin
    assert_difference("Link.count") do
      post links_url, params: { link: { name: @link.name + "Uniqueness", url: @link.url } }
    end

    assert_redirected_to links_url
  end

  test "should show link" do
    get link_url(@link)
    assert_response :redirect
  end

  test "should get edit" do
    sign_in admins(:one), scope: :admin
    get edit_link_url(@link)
    assert_response :success
  end

  test "should update link" do
    sign_in admins(:one), scope: :admin
    patch link_url(@link), params: { link: { hits: @link.hits, name: @link.name, url: @link.url } }
    assert_redirected_to links_url
  end

  test "should destroy link" do
    sign_in admins(:one), scope: :admin

    assert_difference("Link.count", -1) do
      delete link_url(@link)
    end

    assert_response :see_other
    assert_redirected_to links_url
  end
end
