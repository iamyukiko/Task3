class UsersController < ApplicationController
  def show
    @user = user.find(params[:id])
    @books = @user.books
  end

  def edit
  end
end
