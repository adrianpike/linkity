class VotesController < ApplicationController
  before_filter :authenticate_user!
  
  def create
    @vote = Vote.new({
      :voted => Post.find(params[:post_id]),
      :user => current_user
    })
    
    if @vote.save then
      respond_to do |format|
        format.html{
          flash[:notice] = I18n.t('vote.created')
          redirect_to posts_path
        }
        format.js {}
      end
    else
      respond_to do |format|
        format.html {
        }
        format.js {}
      end
    end
  end
  
end