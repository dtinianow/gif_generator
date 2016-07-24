require 'rails_helper'

RSpec.feature "Admin deletes a category" do
  scenario "the category and gifs are removed from the index" do
    admin = User.create(username: "david", password: "password", role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    category = Category.create(name: "Funny")
    category.gifs.create(image_path: "http://media1.giphy.com/media/1313mmmP3ETX3O/giphy.gif")
    expect(Category.count).to eq(1)
    expect(Gif.count).to eq(1)

    visit admin_categories_path

    expect(page).to have_content "Funny"

    click_on "Delete"

    expect(current_path).to eq admin_categories_path
    expect(page).to_not have_content "Funny"
    expect(Category.count).to eq(0)
    expect(Gif.count).to eq(0)
  end
end

RSpec.feature "Admin deletes a gif" do
  scenario "they no longer see the gif in that category" do
    admin = User.create(username: "david", password: "password", role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    category = Category.create(name: "Funny")
    category.gifs.create(image_path: "http://media1.giphy.com/media/1313mmmP3ETX3O/giphy.gif")
    expect(Category.count).to eq(1)
    expect(Gif.count).to eq(1)

    visit admin_category_path(category)

    expect(page).to have_content "Funny"

    click_on "Delete"

    expect(current_path).to eq admin_category_path(category)
    expect(page).to have_content "Funny"
    expect(Category.count).to eq(1)
    expect(Gif.count).to eq(0)
  end
end
