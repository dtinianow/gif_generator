require 'rails_helper'

RSpec.feature "User has an account" do
  scenario "they can create a new account" do
    visit new_user_path

    fill_in "Username", with: "david"
    fill_in "Password", with: "password"

    click_on "Create New Account"

    user = User.find_by(username: "david")

    expect(current_path).to eq(user_path(user))
    expect(page).to have_content "Welcome, david"
  end

  scenario "they can login successfully" do
    user = User.create(username: "david", password: "password")

    visit login_path

    fill_in "Username", with: "david"
    fill_in "Password", with: "password"

    click_on "Login"

    expect(current_path).to eq(user_path(user))
    expect(page).to have_content("Welcome, david")
  end
end
