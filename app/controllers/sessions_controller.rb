class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(uid: params[:uid])
    if user && BCrypt::Password.new(user.pass) == params[:pass]
      session[:login_uid] = user.id
      redirect_to root_path
    else
      render "error", status: 422
    end
  end

  def destroy
    session.delete(:login_uid)
    redirect_to root_path
  end
end
