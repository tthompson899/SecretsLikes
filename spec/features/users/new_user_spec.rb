require "rails_helper"

RSpec.describe "signing us" do
  it "prompts for valid fields" do
    visit "/users/new"
    expect(page).to have_field("register[email]")
    expect(page).to have_field("register[name]")
    expect(page).to have_field("register[password]")
    expect(page).to have_field("register[password_confirmation]")

  end
end
