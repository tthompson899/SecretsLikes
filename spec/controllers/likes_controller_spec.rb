require 'rails_helper'

RSpec.describe LikesController, type: :controller do
  before do
    @user = create_user
    secret = @user.secrets.create(content: "Oops")
    @like = @user.likes.create(user: @user, secret: secret)
  end

  describe "when not logged in" do
    before do
      session[:user_id] = nil
    end

    it "cannot access create" do
      post :create, id: @user
      expect(response).to redirect_to("/sessions/new")
    end

    it "cannot access destory" do
      delete :delete, id: @like
    end
  end

  describe "when logged in as the wrong user" do

    before do
      @wrong_user = create_user "julius", "julius@lakers.com"
      session[:user_id] = @wrong_user.id
      @secret = @user.secrets.create(content: "Oooops")
      @like = @secret.likes.create(user: @user, secret: @secret)
    end

    it "cannot access destory" do
      delete :delete, id: @user
      like = Like.where(user: @user, secret: @secret)
      like.find(like).destroy
      expect(response).to redirect_to("/users/#{@wrong_user.id}")
    end
  end
end
