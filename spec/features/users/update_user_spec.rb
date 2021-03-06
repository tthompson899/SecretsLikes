require "rails_helper"

RSpec.describe "updating user" do
  it "updates user and redirects to profile page" do
    user = create_user
    log_in user
    expect(page).to have_text("drake")
    click_link "Edit Profile"
    fill_in "name", with: "kobe"
    click_button "Update"
    expect(page).not_to have_text("drake")
    expect(page).to have_text("kobe")
  end
end
