class BooksController < ApplicationController
  def index
    # カレントユーザのデータを取得する
    @user = User.find(current_user.id)

    # 全てのユーザのデータを取得する
    #@users = User.all

    # ユーザに紐づくブックデータを取得する
    @books = Book.all

    @book = Book.new

    @error = Book.new
  end

  def show
    # GETパラメータに該当するブックデータを取得する
    @books = Book.find(params[:id])
    #byebug

    # GETパラメータに該当するユーザのデータを取得する
    @user = User.find(@books.user_id)

    @book = Book.new

    #byebug
  end

  def edit
    @book = Book.find(params[:id])
    edit_user_id = @book.user_id.to_i

    if edit_user_id != current_user.id
      redirect_to books_path
    end
  end

  def new

  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @user = current_user
    @books = Book.all
    if @book.save
      #フラッシュメッセージを設定する
      flash[:notice]="Book was successfully created."

      redirect_to book_path(@book.id)
      #redirect_to user_path(@book.user_id)
    else
      #フラッシュメッセージを設定する
      flash[:notice]="Error."

      #redirect_to books_path
      render :index
    end
  end

  #削除
  def destroy
    @book = Book.find(params[:id])
    @book.destroy

    #一覧画面へリダイレクト
    redirect_to books_path
  end

  # 更新
  def update
    @book = Book.find(params[:id])
    @book.update(book_params)

    if @book.save
       #フラッシュメッセージを設定する
      flash[:notice]="You have updated book successfully."

      redirect_to book_path(@book.id)
    else
      #フラッシュメッセージを設定する
      flash[:notice]="Error."

      render :edit
    end
  end

  #ストロングパラメータ
  private
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
