class UsersController < ApplicationController

  def mylist
    @user = User.find(params[:id])
    @posts = @user.posts.order(created_at: :desc).page(params[:page]).per(8)

  end

end
