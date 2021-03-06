class BooksController < ApplicationController
  def home
  end

  def about
  end

  def index
    @books = Book.all.order(created_at: :desc)
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to books_path, notice: 'A new book was successfully created.'
    else
      render :index
    end
  end

  def show
    @book = Book.new
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    @book.user_id = current_user.id
    if @book.update(book_params)
      redirect_to book_path(@book.id), notice: 'Book was successfully updated.'
    else
      render :index
    end
  end

  def destroy
    book = Book.find(params[:id])
    if book.delete
    redirect_to books_path, notice: 'You successfully destroyed it.'
    else
    render :index
    end
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
