class RepliesController < ApplicationController

  before_filter :signed_in_user, :only => [:create]

  def new
  end

  def create
    @reply = current_user.replies.build(params[:reply])
    if @reply.save
      flash[:success] = "Reply added!"
    else
      flash[:error] = "Unable to add reply!"
    end
    redirect_to post_path(@reply.post)
  end

end
