class ItemsController < ApplicationController
  def index
    @user = current_user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path, notice: 'ユーザーが正常に作成されました'
    else
      render :new
    end
  end

  def destroy
    private

    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end
  end
end
