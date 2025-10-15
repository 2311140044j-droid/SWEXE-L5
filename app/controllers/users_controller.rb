class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    if User.find_by(uid: params[:user][:uid])
      @error = "そのユーザIDはすでに存在します"
      render "new"
    else
      @user = User.new(
        uid: params[:user][:uid],
        pass: BCrypt::Password.create(params[:user][:pass])
      )
      if @user.save
        redirect_to "/login"
      else
        render "new"
      end
    end
  end
end
