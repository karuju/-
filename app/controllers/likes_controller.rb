class LikesController < ApplicationController
include ActionView::RecordIdentifier #モデルオブジェクトに関連するHTML要素のIDやクラス名を生成するためヘルパーメソッドを使えるようにする
  before_action :require_login

  def create
    set_likeable
    @like = current_user.likes.build(likeable: @likeable)
    @like.save
  end

  def destroy
    @like = current_user.likes.find_by(params[:id])
    @like.destroy
  end

  private

  def set_likeable
    @likeable = params[:likeable_type].constantize.find(params[:likeable_id])
  end
end
