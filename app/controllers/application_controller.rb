class ApplicationController < ActionController::Base
  #before_action :require_login
  before_action :set_current_user

  def set_current_user
    @current_user = User.find_by(id: session[:user_id])
  end

  private

  def not_authenticated
    redirect_to login_path
  end

  # 未ログインでアクセスしようとしたページのURLをセッションに保存しておく
  def store_location
    if request.get? && !request.xhr?
      session[:forwarding_url] = request.url
    end
  end
end
