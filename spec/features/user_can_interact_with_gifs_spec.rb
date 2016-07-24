require 'rails_helper'

RSpec.feature "User can interact with gifs" do
  scenario "they can see all gifs while not logged in" do

    Category.create(name: "Funny", id: 1)
    Gif.create(image_path: "http://example.com", category_id: 1)

    visit gifs_path

    expect(page).to have_content("All Gifs")
    expect(page).to have_xpath("//img[@src='http://example.com']")
  end
end
