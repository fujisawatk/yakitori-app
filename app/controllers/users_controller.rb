class UsersController < ApplicationController

  def mylist
    @items = current_user.posts
end
