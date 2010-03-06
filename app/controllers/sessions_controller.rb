class SessionsController < ApplicationController
  def new
  end
  
  # This method altered to accommodate using a hashed password - change to variable user instead of @current_user
  def create
    user = User.authenticate(params[:login], params[:password])
    
    if user
      session[:user_id] = user.id
      if session[:return_to]
        redirect_to session[:return_to]
        session[:return_to] = nil
      else
      redirect_to shares_path
    end
    else
      render :action => 'new'
    end
  end

  def destroy
    session[:user_id] = @current_user = nil
  end

end
