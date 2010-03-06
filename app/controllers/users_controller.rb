class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @shares_submitted = @user.shares.find(:all,
      :limit => 6, :order => 'shares.id DESC')
      @shares_voted_on = @user.shares_voted_on.find(:all,
      :limit => 6, :order => 'votes.id DESC' )
  end

end
