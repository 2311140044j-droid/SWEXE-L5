class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

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
        pass: BCrypt::Password.create(params[:user][:pass]),
        name: params[:user][:uid] # 初期値としてuidを入れておく
      )
      if @user.save
        redirect_to "/login"
      else
        render "new"
      end
    end
  end

  def show
  end

  def edit
    redirect_to root_path unless session[:login_uid] == @user.id
  end

  def update
    if session[:login_uid] == @user.id
      if @user.update(user_params)
        redirect_to user_path(@user), notice: "プロフィールを更新しました"
      else
        render "edit", status: 422
      end
    else
      redirect_to root_path
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :bio)
  end
end

