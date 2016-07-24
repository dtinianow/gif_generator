require 'rails_helper'

RSpec.feature "User can have an account" do
  scenario "they can visit the homepage and create a new account" do
    visit root_path

    click_on "Create New Account"
    expect(current_path).to eq (new_user_path)

    fill_in "Username", with: "david"
    fill_in "Password", with: "password"

    click_on "Create New Account"

    user = User.find_by(username: "david")

    expect(current_path).to eq(user_path(user))
    expect(page).to have_content "Welcome, david"
  end

  scenario "they can login successfully" do
    user = User.create(username: "david", password: "password")

    visit root_path

    click_on "Login"
    expect(current_path).to eq(login_path)

    fill_in "Username", with: "david"
    fill_in "Password", with: "password"

    click_on "Login"

    expect(current_path).to eq(user_path(user))
    expect(page).to have_content("Welcome, david")
  end

  scenario "they can logout successfully" do
    user = User.create(username: "david", password: "password")

    visit login_path

    fill_in "Username", with: "david"
    fill_in "Password", with: "password"

    click_on "Login"

    expect(page).to have_content("Welcome, david")

    click_on "Logout"

    expect(current_path).to eq(gifs_path)
    expect(page).to_not have_content("david")
  end
end
