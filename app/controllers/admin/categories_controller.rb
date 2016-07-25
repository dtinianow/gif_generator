class Admin::CategoriesController < Admin::BaseController

  def new
    @category = Category.new
  end

  def create
    category = Category.find_or_create_by(category_params)
    category.gifs.create(image_path: image_path(category))
    redirect_to category
  end

  def destroy
    category = Category.find(params[:id])
    destroy_gifs(category.gifs)
    category.destroy
    redirect_to categories_path
  end

private

  def category_params
    params.require(:category).permit(:name)
  end

  def image_path(category)
    response = Faraday.get("http://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=#{category.name}")
    raw_data = response.body
    parsed = JSON.parse(raw_data, object_class: OpenStruct)
    parsed.data.fixed_height_downsampled_url
  end

  def destroy_gifs(gifs)
    gifs.each do |gif|
      gif.favorites.destroy_all
      gif.destroy
    end
  end
end
