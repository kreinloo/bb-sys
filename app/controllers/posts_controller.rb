class PostsController < ApplicationController

  before_filter :signed_in_user, :only => [:new, :create]

  def index
    @posts = Post.paginate(:page => params[:page], :per_page => 20)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(params[:post])
    if @post.save
      flash[:success] = "Post created!"
      redirect_to post_path @post
    else
      render "new"
    end
  end

  def show
    @post = Post.find(params[:id])
    @reply = Reply.new
    @reply.post_id = @post.id
  end

end
