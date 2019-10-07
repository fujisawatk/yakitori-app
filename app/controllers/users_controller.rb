class UsersController < ApplicationController

  def mylist
    @user = User.find(params[:id])
    @posts = @user.posts.order(created_at: :desc).page(params[:page]).per(8)
    if user_signed_in?
      gon.current_user_id = current_user.id
      gon.current_user_name = current_user.nickname
    end

  end

end
