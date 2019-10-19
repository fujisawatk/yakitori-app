class CategoriesController < ApplicationController
  include SetGon

  def show
    @category = Category.find(params[:id])
    @categories = Category.all
    @posts = @category.posts.order(created_at: :desc).page(params[:page]).per(8)
    set_gon
  end

end
