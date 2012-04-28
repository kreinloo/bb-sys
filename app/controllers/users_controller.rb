require "will_paginate/array"

class UsersController < ApplicationController

  before_filter :signed_in_user, :only => [:index, :edit, :update]
  before_filter :correct_user,   :only => [:edit, :update]

  def index
    @users = User.paginate(:page => params[:page])
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

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated!"
      sign_in @user
      redirect_to @user
    else
      render "edit"
    end
  end

  def show
    #if not @user = User.find_by_name(params[:id])
    if not @user = User.find(:first, :conditions =>
      [ "lower(name) = ?", params[:id].downcase ])
      render "static_pages/notfound"
    end
  end

end
