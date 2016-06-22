class UsersController < ApplicationController
  before_action :require_login, except: [:new, :create]
  before_action :require_correct_user, only: [:show, :edit, :update, :delete]

  def index
    render :text => "Users Controller"
  end
  def new

  end
  def create
    u = User.new(user_params)
    if u.save
      session[:user_id] = u.id
      flash[:success] = "User Created!"
      redirect_to "/users/#{session[:user_id]}"
    else
      flash[:errors] = u.errors.full_messages
      redirect_to :back
    end
  end

  def show
    @user = User.find(params[:id])
    @secret = @user.secrets
    @likes = Secret.joins(:likes)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    user.update(name: params[:name], email: params[:email])
    user.save
    redirect_to "/users/#{user.id}"
  end

  def delete
    session[:user_id] = nil
    redirect_to "/sessions/new"
  end

  private
  def user_params
    params.require(:register).permit(:name, :email, :password, :password_confirmation)
  end

end
