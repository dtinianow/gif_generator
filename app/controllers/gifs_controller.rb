class GifsController < ApplicationController

  def index
    @gifs = Gif.all
  end

  def create
    @favorite = Favorite.find_or_create_by(favorite_params)
    redirect_to gifs_path
  end

private

  def favorite_params
    params.permit(:user_id, :gif_id)
  end
end
