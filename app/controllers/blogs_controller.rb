class BlogsController < ApplicationController
  
  before_action :set_blog, only: [:edit, :update, :destroy]
  before_action :redirect_to_login, only: [:new, :index, :edit, :destroy]
  
  def new
    if params[:back]
      @blog = Blog.new(blog_params)
    else
      @blog = Blog.new
    end
  end

  def confirm
    @blog = Blog.new(blog_params)
    render 'new' if @blog.invalid?
  end
  
  def create
    @blog = Blog.new(blog_params)
    if @blog.save
      redirect_to blogs_path, notice: 'ブログを作成しました！'
    else
      render 'new'
    end
  end

  def edit
  end
  
  def update
    if @blog.update(params.require(:blog).permit(:title, :content))
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
      params.require(:blog).permit(:title, :content)
    end
  
    def set_blog
      @blog = Blog.find(params[:id])
    end
    
    def redirect_to_login
        redirect_to new_session_path if logged_in? == false
    end
    
end
