class VotesController < ApplicationController
  before_filter :login_required
  
  def create  
    @share = Share.find(params[:share_id])
    @share.votes.create(:user => @current_user)
    respond_to do |format|
      format.html { redirect_to @share }
      format.js
    end
  end
end
