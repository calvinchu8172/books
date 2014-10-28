class BooksController < ApplicationController

before_action :set_book, :only => [ :show, :edit, :update, :destroy]

def index
	 # @books = Book.all
	 @books = Book.page(params[:page]).per(5)
end

def new
 	@book = Book.new
end

def create
  @book = Book.new(book_params)
  if @book.save
    #redirect_to :action => :index
    redirect_to books_url
    flash[:notice] = "Book was successfully created"
  else
	render :action => :new
  end
end

def show
  @page_title = @book.name
end

def edit
  
end

def update
  if @book.update_attributes(book_params)
     #redirect_to :action => :show, :id => @book
     redirect_to event_url(@book)
     flash[:notice] = "Book was successfully updated"
  else
  	render :action => :edit
  end
end

def destroy
  @book.destroy
  redirect_to :action => :index
  flash[:alert] = "Book was successfully deleted"
end

private

def set_book
  @book = Book.find(params[:id])
end

def book_params
	params.require(:book).permit(:name, :description, :isbn)
end


end
