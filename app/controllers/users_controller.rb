class UsersController < ApplicationController

  def mylist
    @posts = current_user.posts
  end

end
