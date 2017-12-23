class PostsController < ApplicationController
  before_action :require_user_logged_in, only: [:new, :create, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :destroy]
  
  def show
    @post = Post.find(params[:id])
    @user = @post.user
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = '写真を投稿しました。'
      redirect_to root_url
    else
      @posts = current_user.feed_posts.order('created_at DESC').page(params[:page])
      flash.now[:danger] = '写真の投稿に失敗しました。'
      render 'toppages/index'
    end
  end

  def edit
  end

  def update
    @post = current_user.posts.find(params[:id])
    
    if @post.update(post_params)
      flash[:success] = '投稿は正常に更新されました。'
      redirect_to @post
    else
      flash[:denger] = '投稿は更新されませんでした。'
      render :edit
    end  
  end

  def destroy
    @post.destroy
    flash[:success] = '写真は正常に削除されました。'
    redirect_to user_path(current_user)
  end
  
  private
  
  def post_params
    params.require(:post).permit(:photo, :title, :caption, :used_camera, :color)
  end
  
  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    unless @post 
      redirect_to root_url
    end
  end  
end
