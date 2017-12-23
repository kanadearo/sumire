class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order('created_at DESC').page(params[:page])
    counts(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_create_params)
    
    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      session[:user_id] = @user.id
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end  
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    
    if @user.update(user_update_params)
      flash[:success] = 'プロフィールは正常に更新されました。'
      redirect_to @user
    else
      flash.now[:danger] = 'プロフィールは更新されませんでした。'
      render :edit
    end      
  end

  def followings
    @user = User.find(params[:id])
    @posts = @user.posts.order('created_at DESC').page(params[:page])
    @followings = @user.followings.page(params[:page])
    counts(@user)
  end
  
  def followers
    @user = User.find(params[:id])
    @posts = @user.posts.order('created_at DESC').page(params[:page])
    @followers = @user.followers.page(params[:page])
    counts(@user)
  end

  def favoritings
    @user = User.find(params[:id])
    @favoritings = @user.favoritings.page(params[:page])
    counts(@user)
  end

  private
  
  def user_create_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :account_image)
  end
  
  def user_update_params
    params.require(:user).permit(:header_image, :account_image, :name, :profile, :use_camera, :url)
  end

end
