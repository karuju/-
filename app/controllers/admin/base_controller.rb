class Admin::BaseController < ApplicationController
  before_action :check_admin
  layout 'admin/layouts/application'

  private

  def not_authenticate
    flash[:warning] =  "ログインしてください"
    redirect_to admin_login_path
  end

  def check_admin
    redirect_to root_path, danger: "権限がありません" unless current_user.admin?
  end
end
