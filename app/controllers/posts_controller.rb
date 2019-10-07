class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @posts = Post.includes(:user).order(created_at: :desc).page(params[:page]).per(8)
    @categories = Category.all
    if user_signed_in?
    gon.current_user_id = current_user.id
    gon.current_user_name = current_user.nickname
    end
  end

  def new
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.includes(:user)
    @comment = Comment.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if user_signed_in? && current_user.id == @post.user_id
      @post.destroy
      redirect_to root_path
    else
      render :show
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :img, category_ids: [],
                                restaurant_attributes: [:id, :name, :url]).merge(user_id: current_user.id)
  end

end
