class ApplicationController < ActionController::Base
#ログイン認証が成功していないと、トップページ以外の画面（ログインと新規登録は除く）は表示できない
#すべてのコントローラで、最初にbefore_actionメソッドが実行されます。
before_action :authenticate_user!, except: [:top,:about]

before_action :configure_permitted_parameters, if: :devise_controller?
  #deviseのサインアップ後の処理
  def after_sign_in_path_for(resource)
    flash[:notice]="Welcome! You have signed up successfully."

    #ユーザ投稿一覧画面を呼び出す
    user_path(current_user.id)
  end

  #deviseのログイン後の処理
  def after_sign_up_path_for(resource)
    flash[:notice]="Signed in successfully."

    #ユーザ投稿一覧画面を呼び出す
    user_path(current_user.id)
  end

  #deviseのログアウト後の処理
  def after_sign_out_path_for(resource)
    flash[:notice]="Signed out successfully."

    root_path
  end

  protected

  def configure_permitted_parameters
   #devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end
end
