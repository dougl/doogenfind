class SharesController < ApplicationController
  before_filter :login_required, :only => [ :new, :create ]
  
  def index
    fetch_shares 'votes_count >= 0'
    end
    
  def bin
    fetch_shares 'votes_count < 5'
    render :action => 'index'
  end
  
  
  def popular
    fetch_shares 'votes_count >= 5'
       render :action => 'index'
  end
  
  def new
    @share = Share.new
  end
  
  def create
    @share = @current_user.shares.build params[:share]
    if @share.save
    flash[:notice] = 'Share submission succeeded'
    redirect_to shares_path
  else
    render :action => 'new'
    end
  end

  def show
    @share = Share.find(params[:id])
  end
  
  protected
  def fetch_shares(conditions)
    @shares = Share.find :all,
      :order => 'id DESC',
      :limit => '60',
      :conditions => conditions
  end
 
end
