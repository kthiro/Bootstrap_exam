class UsersController < ApplicationController
  def new
    if params[:back]
      @user = User.new(user_params)
    else
      @user = User.new
    end
  end
  
  def confirm
    @user = User.new(user_params)
    render 'new' if @user.invalid?
  end
  
  def create
    @user = User.new(user_params)
    
    begin
      if @user.save
        flash[:success] = "アカウントを作成しました！作成したアカウントでログインしてください。"
        redirect_to new_session_path
      else
        render 'new'
      end
    rescue ActiveRecord::RecordNotUnique => e
      flash.now[:danger] = "既に登録済みのメールアドレスです。他のメールアドレスで登録してください。"
      render 'new'
    end

  end
  
  def show
    @user = User.find(params[:id])
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
end