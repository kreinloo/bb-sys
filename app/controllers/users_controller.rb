class UsersController < ApplicationController

  def index
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "Registration completed!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
    if User.exists?(params[:id])
      @user = User.find(params[:id])
    else
      @user = nil
    end
  end

end
