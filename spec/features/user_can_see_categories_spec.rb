require 'rails_helper'

RSpec.feature "User can see can see categories" do
  scenario "they can see all categories while not logged in" do
    Category.create(name: "Funny")

    visit categories_path

    expect(current_path).to eq(categories_path)
    expect(page).to have_content "All Categories"
    expect(page).to have_content "Funny"
  end

  scenario "they can see an individual category page while not logged in" do
    category = Category.create(name: "Funny")

    visit category_path(category)

    expect(page).to have_content "Funny"
  end
end
