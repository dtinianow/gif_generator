class UsersController < ApplicationController

  def new
    redirect_to root_path if current_user
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      flash[:success] = "You have successfully created a new account!"
      redirect_to user
    else
      flash.now[:failure] = "Your login attempt was invalid.  Please try again."
      render :new
    end
  end

  def show
    if current_user.id == params[:id].to_i
      @user = User.find(params[:id])
    else
      render file: "/public/404"
    end
  end


  private

  def user_params
    params.require(:user).permit(:username, :password)
  end

end
