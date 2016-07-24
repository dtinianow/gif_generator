class Admin::GifsController < Admin::BaseController

  def destroy
   gif = Gif.find(params[:id])
   gif.destroy
   redirect_to admin_category_path(gif.category)
  end

end
