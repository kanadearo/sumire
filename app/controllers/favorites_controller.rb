class FavoritesController < ApplicationController
  before_action :require_user_logged_in

  def create
    post = Post.find(params[:post_id])
    current_user.favorite(post)
    flash[:success] = 'この投稿をお気に入りに登録しました。'
    redirect_to user_path(current_user)
  end

  def destroy
    post = Post.find(params[:post_id])
    current_user.unfavorite(post)
    flash[:success] = "この投稿のお気に入りを解除しました。"
    redirect_to user_path(current_user)
  end
end
