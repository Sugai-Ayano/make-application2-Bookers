class BooksController < ApplicationController
  before_action :user_filter, only: [:destroy, :edit, :update]
  before_action :authenticate_user!
  def homes
  end

  def index
      @book = Book.new
      @books = Book.all
      @user = current_user
  end

  def show
     @book = Book.find(params[:id])
     @book_new = Book.new
     @books = Book.all
     @user = @book.user
     @users = User.all
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @books = Book.all
    @user = current_user
    if @book.save
    flash[:notice]='Book was successfully created.'
      redirect_to book_path(@book.id)
    else
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
    flash[:notice]='Book was successfully updated.'
    redirect_to book_path
    else
    render 'edit'
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    flash[:notice]='Book was successfully destroyed.'
    redirect_to books_path
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end

  def user_filter
    @book = Book.find(params[:id])
   if current_user == @book.user
   else redirect_to books_path
   end
  end
end