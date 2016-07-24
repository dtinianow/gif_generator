require 'rails_helper'

RSpec.feature "Admin controls categories and gifs" do
  scenario "while logged in they see admin categories index" do
    admin = User.create(username: "david", password: "password", role: 1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    category = Category.create(name: "Funny")

    visit admin_categories_path

    expect(page).to have_content "Admin Categories"
    expect(page).to have_content "Funny"
  end

  scenario "default user does not see admin categories index" do
    user = User.create(username: "david", password: "password")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit admin_categories_path

    expect(page).to_not have_content "Admin Categories"
    expect(page).to have_content "The page you were looking for doesn't exist."
  end
end
