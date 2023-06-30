class BooksController < ApplicationController
  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
  end

  def create
    @user = current_user
    @book = @user.books.new(book_params)
    @book.user_id = @current_user.id
    if @book.save
    flash[:notice1] = "You have created book successfully."
    redirect_to book_path(@book.id)
    else
      @books = Book.all
      @user = current_user
      render :index
    end
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
    flash[:notice2] = "You have updated book successfully."
    redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to "/books"
  end

 private
 def book_params
   params.require(:book).permit(:title, :body, :user_id)
 end

end
