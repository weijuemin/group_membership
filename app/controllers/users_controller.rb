class UsersController < ApplicationController
  def index
    if logged_in
      redirect_to "/groups"
    end
  end

  def login
    if logged_in
      redirect_to "/groups"
    end
    user = User.find_by(email: params[:user][:email])
    if user
      if user.authenticate(params[:user][:password])
        session[:id] = user.id
        redirect_to "/groups"
      else
        session[:id] = nil
        flash[:error] = ["Password incorrect"]
        redirect_to "/"
      end
    else
      flash[:error] = ["User not found"]
      redirect_to "/"
    end
  end

  def create
    if logged_in
      redirect_to "/groups"
    end
    user = User.create(user_params)
    if user.valid?
      session[:id] = user.id
      redirect_to "/groups"
    else
      flash[:error] = user.errors.full_messages
      redirect_to "/"
    end
  end

  def logout
    if logged_in
      session.clear
    end
    redirect_to "/"
  end


  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
