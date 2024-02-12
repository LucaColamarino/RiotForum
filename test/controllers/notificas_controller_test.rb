require "test_helper"

class NotificasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @notifica = notificas(:one)
  end

  test "should get index" do
    get notificas_url
    assert_response :success
  end

  test "should get new" do
    get new_notifica_url
    assert_response :success
  end

  test "should create notifica" do
    assert_difference("Notifica.count") do
      post notificas_url, params: { notifica: { content: @notifica.content, from: @notifica.from, read: @notifica.read, to: @notifica.to } }
    end

    assert_redirected_to notifica_url(Notifica.last)
  end

  test "should show notifica" do
    get notifica_url(@notifica)
    assert_response :success
  end

  test "should get edit" do
    get edit_notifica_url(@notifica)
    assert_response :success
  end

  test "should update notifica" do
    patch notifica_url(@notifica), params: { notifica: { content: @notifica.content, from: @notifica.from, read: @notifica.read, to: @notifica.to } }
    assert_redirected_to notifica_url(@notifica)
  end

  test "should destroy notifica" do
    assert_difference("Notifica.count", -1) do
      delete notifica_url(@notifica)
    end

    assert_redirected_to notificas_url
  end
end
