class RepliesController < ApplicationController

  before_filter :signed_in_user, :only => [:create]

  def create
  end

end
