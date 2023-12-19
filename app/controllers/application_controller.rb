class ApplicationController < ActionController::Base
  #before_action :require_login

  private

  def not_authenticated
    redirect_to login_path
  end

  # 未ログインでアクセスしようとしたページのURLをセッションに保存しておく
  def store_location
    if request.get? && !request.xhr?
      session[:forwarding_url] = request.forwarding_url
    end
  end
end
