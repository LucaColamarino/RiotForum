require "application_system_test_case"

class NotificasTest < ApplicationSystemTestCase
  setup do
    @notifica = notificas(:one)
  end

  test "visiting the index" do
    visit notificas_url
    assert_selector "h1", text: "Notificas"
  end

  test "should create notifica" do
    visit notificas_url
    click_on "New notifica"

    fill_in "Content", with: @notifica.content
    fill_in "From", with: @notifica.from
    check "Read" if @notifica.read
    fill_in "To", with: @notifica.to
    click_on "Create Notifica"

    assert_text "Notifica was successfully created"
    click_on "Back"
  end

  test "should update Notifica" do
    visit notifica_url(@notifica)
    click_on "Edit this notifica", match: :first

    fill_in "Content", with: @notifica.content
    fill_in "From", with: @notifica.from
    check "Read" if @notifica.read
    fill_in "To", with: @notifica.to
    click_on "Update Notifica"

    assert_text "Notifica was successfully updated"
    click_on "Back"
  end

  test "should destroy Notifica" do
    visit notifica_url(@notifica)
    click_on "Destroy this notifica", match: :first

    assert_text "Notifica was successfully destroyed"
  end
end
