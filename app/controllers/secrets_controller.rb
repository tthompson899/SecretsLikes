class SecretsController < ApplicationController
  before_action :require_login, only: [:index, :create, :delete]
  before_action :require_correct_user, only: [:create, :delete]

  def index
    @secrets = Secret.all
    
  end

  def create
    user = User.find(params[:id])
    secret = user.secrets.create(content: params[:secret])
    redirect_to "/users/#{user.id}"
  end

  def delete
    secret = Secret.find(params[:secret_id])
    secret.destroy if secret.user == current_user
      redirect_to "/users/#{params[:id]}"
  end
end
