class UsersController < ApplicationController
  def new
    if params[:back]
      @user = User.new(user_params)
      image_retrieves_from_cache
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
    image_retrieves_from_cache
    @user.save!
    
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
    @favorite_blogs = @user.favorite_blogs
    @blogs = Blog.where(user_id: current_user.id)
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image, :image_cache)
  end
  
  def image_retrieves_from_cache
    @user.image.retrieve_from_cache! params[:cache][:image]
  end
end