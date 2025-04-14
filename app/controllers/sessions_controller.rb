class SessionsController < ApplicationController
  def new
    # ログイン画面を表示するためのアクション
  end

  def create
    # ログイン処理
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path, notice: 'ログアウトしました'
    private

    def log_out
      session.delete(:user_id)
      @current_user = nil
    end

    def logged_in?
      !current_user.nil?
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end
end
