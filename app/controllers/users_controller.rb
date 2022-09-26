class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update]

  def index
    @booknew = Book.new
    @users = User.all
    @user = current_user
  end

  def create
    @booknew = Book.new(user_params)
    @booknew.user_id = current_user.id
    if @booknew.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.user.id)
    else
      @books = Book.all
      render :show
    end
  end

  def show
    @user = User.find(params[:id])
    @book = @user.books
    @booknew = Book.new

  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
      else
      render :edit
    end
  end

  private

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
    redirect_to user_path(current_user.id)
    end
  end

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

end
