class FavoritesController < ApplicationController
  def create
    @favorite = Favorite.new(user_id: current_user.id, blog_id: params[:blog_id])
    @favorite.save
    redirect_to blogs_path, notice: 'お気に入りに保存しました'
  end
  
  def destroy
    @favorite = Favorite.find(params[:id])
    @favorite.destroy
    redirect_to blogs_path, notice: 'お気に入りを解除しました'
  end

end
