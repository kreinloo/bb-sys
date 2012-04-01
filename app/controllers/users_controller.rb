class UsersController < ApplicationController

  def index
    redirect_to root_path
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Registration completed!"
      redirect_to @user
    else
      render "new"
    end
  end

  def show
    if User.exists?(params[:id])
      @user = User.find(params[:id])
    else
      render "static_pages/notfound"
    end
  end

end
