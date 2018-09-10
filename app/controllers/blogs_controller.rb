class BlogsController < ApplicationController
  
  before_action :set_blog, only: [:edit, :show, :update, :destroy]
  before_action :redirect_to_login, only: [:new, :index, :edit, :destroy]
  
  def new
    if params[:back]
      @blog = Blog.new(blog_params)
      image_retrieves_from_cache
    else
      @blog = Blog.new
      @blog[:user_id] = current_user.id
    end
  end

  def confirm
    @blog = Blog.new(blog_params)
    render 'new' if @blog.invalid?
  end
  
  def create
    @blog = Blog.new(blog_params)
    image_retrieves_from_cache
    
    if @blog.save
      # BlogMailer.blog_mail(@blog).deliver
      redirect_to blogs_path, notice: 'ブログを作成しました！'
    else
      render 'new'
    end
  end

  def edit
  end
  
  def show
    @user = User.find(@blog[:user_id])
    @favorites = @blog.favorites
    @favorite = @favorites.find_by(user_id: current_user[:id])
  end
  
  def update
    if @blog.update(blog_params)
      redirect_to blogs_path, notice: 'ブログを編集しました！'
    else
      render 'edit'
    end
  end

  def index
    @blog = Blog.all
  end
  
  def destroy
    @blog.destroy
    redirect_to blogs_path, notice: 'ブログを削除しました！'
  end
  
  def top
  end
  
  
  private
  
  def blog_params
    params.require(:blog).permit(:title, :content, :user_id, :image, :image_cache)
  end
  
  def set_blog
    @blog = Blog.find(params[:id])
  end
    
  def redirect_to_login
      redirect_to new_session_path if logged_in? == false
  end
  
  def image_retrieves_from_cache
    @blog.image.retrieve_from_cache! params[:cache][:image]
  end
end
