class CommentsController < ApplicationController
   before_filter :login_required
 
    def create
       @share = Share.find(params[:share_id])
         @comment = @share.comments.create(params[:comment].merge(:user => @current_user))
       respond_to do |format|
         format.html { redirect_to @share }
         format.js
       end
     end
   end