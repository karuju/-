class Admin::UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy]
  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true).page(params[:page]).order(created_at: :desc)
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_user_path(@user), success: "Userの更新に成功しました"
    else
      flash[:danger] = "Userの更新に失敗しました"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy!
    redirect_to admin_users_path, success: "削除しました", status: :see_other
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :email, :image, :introduction, :sex, :birthday, :password, :password_confirmation)
    end
  
end
