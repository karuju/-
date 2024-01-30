class PasswordResetsController < ApplicationController
  skip_before_action :require_login
  def new
  end

  # パスワードリセットのリクエスト
  # ユーザーがパスワードリセットフォームにメールアドレスを入力して送信すると実行される
  def create
    @user = User.find_by(email: params[:email]) # emailでユーザーを特定する
    @user&.deliver_reset_password_instructions!
    # トークンを作成してメールを送信
    redirect_to login_path, success: "メールを送信しました"
  end

  def edit
    @token = params[:id] # メールに記載のURLにアクセスしたら送られてくる
    @user = User.load_from_reset_password_token(params[:id]) # トークンに基づいてユーザーを特定するメソッド
    return not_authenticated if @user.blank?
  end

  def update
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])
    return not_authenticated if @user.blank?

    # ↓パスワード確認の検証
    @user.password_confirmation = params[:user][:password_confirmation]
    # ↓一時トークンをクリア、パスワードを更新
    if @user.change_password(params[:user][:password])
      redirect_to login_path, success: "パスワードを再設定しました"
    else
      flash[:danger] = "パスワードの更新に失敗しました"
      render :edit, status: :unprocessable_entity
    end
  end
end
