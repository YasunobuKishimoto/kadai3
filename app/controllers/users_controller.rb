class UsersController < ApplicationController
  # 指定のアクションのみ実行時、ユーザチェック処理共通処理を呼び出す
  before_action :is_matching_login_user, only: [:edit, :update]

  # ユーザ一覧画面の表示処理
  def index
      # カレントユーザのデータを取得する
      @user = User.find(current_user.id)

      # 全てのユーザのデータを取得する
      @users = User.all

      # ユーザに紐づくブックデータを取得する
      @books = @user.books

      @book = Book.new
  end

 # ログインユーザメイン画面表示処理
  def show
      # GETパラメータに該当するユーザのデータを取得する
      @user = User.find(params[:id])

      # 該当のユーザに紐づくブックデータを取得する
      @books = @user.books

      @book = Book.new
  end

  def edit
    # # ここから追加
    # user_id = params[:id].to_i
    # login_user_id = current_user.id
    # if(user_id != login_user_id)
    #   redirect_to post_images_path
    # end
    # # ここまで追加

      @user = User.find(params[:id])
  end

  def update
    #ユーザチェック共通処理呼び出し
    #before_actionで共通処理を呼び出す
    # is_matching_login_user

    @user = User.find(params[:id])
    @user.update(user_params)

    if @user.save
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  #ストロングパラメータ
  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  #ログインチェック共通処理
  def is_matching_login_user
    user_id = params[:id].to_i
    login_user_id = current_user.id
    if(user_id != login_user_id)
      redirect_to user_session_path
    end
  end
end
