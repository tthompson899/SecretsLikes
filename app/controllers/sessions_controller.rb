class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to "/users/#{session[:user_id]}"
    else
      flash[:errors] = "Invalid Credentials"
      redirect_to :back
    end
  end

  def delete
    session[:user_id] = nil
    redirect_to "/sessions/new"
  end

end
