class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    @categories = Category.all
    @posts = @category.posts.order(created_at: :desc).page(params[:page]).per(8)
  end
end
