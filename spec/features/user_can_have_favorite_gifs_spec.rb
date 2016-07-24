require 'rails_helper'

RSpec.feature "User can have favorite gifs" do
  scenario "they select from all gifs and see a page with those selected gifs" do
    user = User.create(username: "joe", password: "password")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    category = Category.create(name: "Funny")
    gif = category.gifs.create(image_path: "http://media1.giphy.com/media/1313mmmP3ETX3O/giphy.gif")

    expect(Category.count).to eq(1)
    expect(Gif.count).to eq(1)
    expect(Favorite.count).to eq(0)

    visit gifs_path

    expect(page).to have_xpath("//img[@src='http://media1.giphy.com/media/1313mmmP3ETX3O/giphy.gif']")
    click_on "Favorite"

    expect(current_path).to eq(gifs_path)

    click_on "Return Home"
    click_on "My Dashboard"
    expect(Favorite.count).to eq(1)
    expect(current_path).to eq(user_favorites_path(user))
    expect(page).to have_xpath("//img[@src='http://media1.giphy.com/media/1313mmmP3ETX3O/giphy.gif']")
  end
end
