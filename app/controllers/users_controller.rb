class UsersController < ApplicationController
  include SetGon

  def mylist
    @user = User.find(params[:id])
    @categories = Category.all
    @posts = @user.posts.order(created_at: :desc).page(params[:page]).per(8)
    set_gon
  end

end
