class TweetsController < ApplicationController
  def index
    @tweets = Tweet.all.includes(:user, :likes)
    @user = User.find_by(id: session[:login_uid]) if session[:login_uid]
  end

  def create
    if session[:login_uid]
      Tweet.create(
        message: params[:message],
        user_id: session[:login_uid] 
      )
    end
    redirect_to root_path
  end

  def like
    if session[:login_uid]
      user = User.find(session[:login_uid])
      Like.find_or_create_by(user_id: user.id, tweet_id: params[:id])
    end
    redirect_to root_path
  end

  def unlike
    if session[:login_uid]
      user = User.find(session[:login_uid])
      like = Like.find_by(user_id: user.id, tweet_id: params[:id])
      like.destroy if like
    end
    redirect_to root_path
  end
end
