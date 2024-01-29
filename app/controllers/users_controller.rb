class UsersController < ApplicationController
  before_action :store_location, only: %i[ show ]
  skip_before_action :require_login, only: %i[ new create ]

  # GET /users or /users.json
  def index
  end

  # GET /users/1 or /users/1.json
  def show
    @user = User.find(params[:id])
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)
      if @user.save
        login(@user.email, user_params[:password])
        redirect_to user_path(@user), success: "ユーザー登録が成功しました" 
      else
        flash[:danger] = "ユーザー登録に失敗しました"
        render :new, status: :unprocessable_entity
      end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.assign_boards_and_answers_and_posts_to_deleted_user
    @user.destroy
    redirect_to root_path, success: "ユーザーを削除しました" 
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :email, :image, :introduction, :sex, :birthday, :password, :password_confirmation)
    end
end
