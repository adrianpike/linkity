class PostsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index,:newest]
  
  def index
    @posts = Post.top
  end
  
  def newest
#    @posts = 
    render :index
  end
  
  def show
    @post = Post.find(params[:id])
    @comment = Comment.new(:post => @post)
  end
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(params[:post])
    @post.user = current_user
    
    if @post.save then
      flash[:notice] = I18n.t('post.created')
      redirect_to '/'
    else
      render :new
    end
  end
  
  def destroy
    
  end
  
end