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
    if not @user = User.find_by_name(params[:id])
      render "static_pages/notfound"
    end
  end

end
