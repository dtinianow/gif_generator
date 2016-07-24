require 'rails_helper'

RSpec.feature "Admin creates a new category and gif" do
  scenario "they see the page for that category with that gif on it" do
    admin = User.create(username: "david", password: "password", role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    expect(Category.count).to eq(0)
    expect(Gif.count).to eq(0)

    visit user_path(admin)

    click_on "Create a New Gif"

    fill_in "Name", with: "Wacky"
    click_on "Generate Gif"

    expect(page).to have_content "Wacky"

    expect(Category.count).to eq(1)
    expect(Gif.count).to eq(1)
  end
end

RSpec.feature "Admin creates a gif for a category that already exists" do
  xscenario "they see that category page with the gif on it" do
    admin = User.create(username: "david", password: "password", role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    Category.create(name: "Wacky")
    result = Category.count
    expect(result).to eq(1)

    visit admin_categories_path

    click_on "Create a New Gif"

    fill_in "Name", with: "Wacky"
    click_on "Generate Gif"

    expect(page).to have_content "Wacky"
    expect(result).to eq(1)
  end
end
