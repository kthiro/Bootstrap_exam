class SessionsController < ApplicationController
  
  before_action :redirect_to_user_profile, only: [:new]
  
  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to user_path(user.id), notice: 'ログインしました！'
    else
      flash.now[:danger] = 'ログインに失敗しました！'
      render 'new'
    end
  end
  
  def destroy
    session.delete(:user_id)
    flash[:warning] = 'ログアウトしました！'
    redirect_to new_session_path
  end
  
  private
  
  def redirect_to_user_profile
    redirect_to user_path(current_user.id), notice: '既にログインしています！' if logged_in?
  end
end
