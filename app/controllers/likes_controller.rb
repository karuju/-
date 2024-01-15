class LikesController < ApplicationController
include ActionView::RecordIdentifier #モデルオブジェクトに関連するHTML要素のIDやクラス名を生成するためヘルパーメソッドを使えるようにする
  before_action :require_login

  def create
    set_likeable
    @like = current_user.likes.build(likeable: @likeable)
    if @like.save
      respond_to do |format|
        format.turbo_stream
        format.html { set_redirect }
      end
    else
      Rails.logger.error @like.errors.full_messages.join("\n")
    end
  end

  def destroy
    @like = current_user.likes.find_by(params[:id])
    @likeable = @like.likeable
    @like.destroy
    if @like.destroy
      respond_to do |format|
        format.turbo_stream
        format.html { set_redirect }
      end
    else
      Rails.logger.error @like.errors.full_messages.join("\n")
    end
  end

  private

  def set_likeable
    @likeable = params[:likeable_type].constantize.find(params[:likeable_id])
  end

  def set_redirect
    case @likeable.class.to_s
    when 'Post'
      redirect_to posts_path
    when 'Board'
      redirect_to boards_path
    when 'Answer'
      redirect_to post_path(@likeable_id)
    else
      redirect_to root_path
    end
  end

end
