class BooksController < ApplicationController
  def new
    @book = Book.new
  end
  
  def create
		   @book = Book.new(book_params)
       @book.user_id = (current_user.id)
	    if @book.save
         flash[:notice] = "You have creatad book successfully."
		     redirect_to  book_path(@book.id)
      else
         @user = current_user
         @books = Book.all
         render :index
      end
	end

  def index
    @books = Book.all
    @user = current_user
    @book = Book.new
  end

  def show
    @user = current_user
    @book = Book.find(params[:id])
    @book_new = Book.new
    
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
        render "edit"
    else
        redirect_to books_path
    end    
  end
  
  def update
        @book = Book.find(params[:id])
        if @book.update(book_params)
        flash[:notice] = "You have update book successfully."
        redirect_to  book_path(@book.id)

        else
        @books = Book.all
         flash[:notice]= ' errors prohibited this obj from being saved:'
        render "edit"
        end
  end
  
  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to '/books'
  end
  
  private
  def book_params
    params.require(:book).permit(:title, :body)
  end
  def user_params
    params.require(:user).permit(:name,:profile_image,:introduction)
  end
  
  def  ensure_current_user
      @book = Book.find(params[:id])
     if @book.user_id != current_user.id
        redirect_to books_path
     end
  end
end
