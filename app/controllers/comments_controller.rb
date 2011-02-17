class CommentsController < ApplicationController
  before_filter :authenticate_user!
    
  def create
    @comment = Comment.new(params[:comment])
    @comment.user = current_user
    @comment.post = Post.find(params[:post_id]) if params[:post_id]
    
    if @comment.save then
      flash[:notice] = I18n.t('comment.created')
      redirect_to :back
    else
      redirect_to :back
    end
  end
  
end