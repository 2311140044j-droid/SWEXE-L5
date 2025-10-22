class TweetsController < ApplicationController
  before_action :require_login, except: [:index]
  before_action :set_tweet, only: [:destroy]

  def index
    @tweets = Tweet.includes(:user, :likes).order(created_at: :desc)
    @tweet = Tweet.new
  end

  def create
    @tweet = current_user.tweets.build(tweet_params)
    if @tweet.save
      redirect_to root_path, notice: 'つぶやきを投稿しました'
    else
      @tweets = Tweet.includes(:user, :likes).order(created_at: :desc)
      render :index, status: :unprocessable_entity
    end
  end

  def destroy
    if @tweet.user == current_user
      @tweet.destroy
      redirect_to root_path, notice: 'つぶやきを削除しました'
    else
      redirect_to root_path, alert: '他人のつぶやきは削除できません'
    end
  end

  private

  def tweet_params
    params.require(:tweet).permit(:content)
  end

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  def require_login
    unless logged_in?
      redirect_to login_path, alert: 'ログインが必要です'
    end
  end
end
