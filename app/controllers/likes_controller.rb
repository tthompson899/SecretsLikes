class LikesController < ApplicationController
  before_action :require_login, only: [:create, :delete]
  before_action :require_correct_user, only: [:create, :delete]
  def index
    @likes = Like.all
    
  end
  def create
    user = User.find(params[:id])
    secret = Secret.find(params[:secret_id])
    like = Like.create(user: user, secret: secret)
    redirect_to "/secrets"
  end

  def delete
    # user = User.find(params[:id])
    # secret = Secret.find(params[:secret_id])
    like = Like.where(user_id: params[:id], secret_id: params[:secret_id])
    like.find(like).destroy
    redirect_to "/secrets"
  end
end
