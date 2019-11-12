class UsersController < ApplicationController
  before_action :set_params
  def mylist
    @posts = @user.posts.order(created_at: :desc).page(params[:page]).per(8)
  end

  def mycomment
    @comment_posts = @user.comments.order(created_at: :desc)
    @array_posts = @comment_posts.map(&:post).flatten
    @posts = Kaminari.paginate_array(@array_posts).page(params[:page]).per(8)
  end

  def myliked
    @liked_posts = @user.likes.order(created_at: :desc)
    @array_posts = @liked_posts.map(&:post).flatten
    @posts = Kaminari.paginate_array(@array_posts).page(params[:page]).per(8)
  end

  private

  def set_params
    @user = User.find(params[:id])
    @categories = Category.all
  end
end
