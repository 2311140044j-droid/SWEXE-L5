class LikesController < ApplicationController
  before_action :require_login

  def create
    tweet = Tweet.find(params[:tweet_id])
    current_user.like(tweet)
    redirect_to root_path, notice: 'いいねしました'
  end

  def destroy
    tweet = Tweet.find(params[:tweet_id])
    current_user.unlike(tweet)
    redirect_to root_path, notice: 'いいねを外しました'
  end

  private

  def require_login
    unless logged_in?
      redirect_to login_path, alert: 'ログインが必要です'
    end
  end
end
