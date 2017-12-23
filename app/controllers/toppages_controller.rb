class ToppagesController < ApplicationController
  def index
    if logged_in?
      @user = current_user
      @posts = current_user.feed_posts.order('created_at DESC').page(params[:page])
    end  
  end
end
