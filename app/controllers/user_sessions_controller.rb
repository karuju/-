class UserSessionsController < ApplicationController
  def new
  end

  def create
    @user = login(params[:email], params[:password])

    if @user
      redirect_to(session[:forwarding_url] || root_path )
      session.delete(:forwarding_url)
    else
      flash.now[:alert] = 'ログインに失敗しました'
      render :new
      
    end
  end

  def destroy
    logout
    redirect_to root_path, status: :see_other
  end
end
