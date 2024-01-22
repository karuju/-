class Admin::ArtistsController < ApplicationController
  before_action :set_artist, only: %i[show edit update destroy]
  def index
    @q = Artist.ransack(params[:q])
    @artists = @q.result(distinct: true).page(params[:page]).order(created_at: :desc)
  end

  def show
  end

  def edit
  end

  def update
    if @artist.update(artist_params)
      redirect_to admin_artist_path(@artist), success: "Artistの更新に成功しました"
    else
      flash[:danger] = "Artistの更新に失敗しました"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @artist.destroy!
    redirect_to admin_artists_path, success: "削除しました", status: :see_other
  end

  private

    def set_artist
      @artist = Artist.find(params[:id])
    end

    def artist_params
      params.require(:artist).permit(:name, :uri, :image)
    end
end
