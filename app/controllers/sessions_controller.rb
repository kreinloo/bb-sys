class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_name(params[:session][:username])
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_back_or user
    else
      flash[:error] = "Invalid username/password!"
      redirect_to signin_path
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end

end
