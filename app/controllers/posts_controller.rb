# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :search]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :set_categories, only: [:index, :show, :search]

  def index
    @posts = Post.includes(:user).order(created_at: :desc).page(params[:page]).per(8)
  end

  def new
    @post = Post.new
  end

  def show
    @comments = @post.comments.includes(:user)
    @comment = Comment.new
    @like = Like.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to root_path, notice: '記事を投稿しました'
    else
      render :new
    end
  end

  def edit
    if user_signed_in? && current_user.id == @post.user.id
      render :edit
    else
      redirect_to root_path, alert: '記事を編集出来ません。'
    end
  end

  def update
    if @post.update(post_params)
      redirect_to mylist_user_path(@post.user), notice: '記事を編集しました。'
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to mylist_user_path(@post.user), notice: '記事を削除しました。'
  end

  def search
    @posts = query.order(created_at: :desc).page(params[:page]).per(8)
  end

  private

  def post_params
    params.require(:post)
          .permit(:title, :body, :img, category_ids: [], restaurant_attributes: [:id, :name, :url])
          .merge(user_id: current_user.id)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def set_categories
    @categories = Category.all
  end

  def query
    params[:post].present? && params[:post][:keyword]
    Post.joins(:restaurant).where('title LIKE ? OR body L IKE ? OR name LIKE ?',
                                  "%#{params[:post][:keyword]}%",
                                  "%#{params[:post][:keyword]}%",
                                  "%#{params[:post][:keyword]}%")
  end
end
