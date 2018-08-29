class BlogsController < ApplicationController
  def new
    if params[:back]
      @blog = Blog.new(params.require(:blog).permit(:title, :content))
    else
      @blog = Blog.new
    end
  end

  def confirm
    @blog = Blog.new(params.require(:blog).permit(:title, :content))
    render 'new' if @blog.invalid?
  end
  
  def create
    @blog = Blog.new(params.require(:blog).permit(:title, :content))
    if @blog.save
      redirect_to blogs_path, notice: 'ブログを作成しました！'
    else
      render 'new'
    end
  end

  def edit
    @blog = Blog.find(params[:id])
  end
  
  def update
    @blog = Blog.find(params[:id])
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
    @blog = Blog.find(params[:id])
    @blog.destroy
    redirect_to blogs_path, notice: 'ブログを削除しました！'
  end
  
  def top
  end
end
