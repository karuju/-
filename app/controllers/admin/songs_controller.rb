class Admin::SongsController < ApplicationController
  before_action :set_song, only: %i[ show edit update destroy ]
  def index
    @q = Song.ransack(params[:q])
    @songs = @q.result(distinct: true).page(params[:page]).order(created_at: :desc)
  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @song.update(song_params)
        format.html { redirect_to admin_song_url(@song), notice: "Song was successfully updated." }
        format.json { render :show, status: :ok, location: @song }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @song.destroy
    redirect_to admin_songs_path, success: "削除しました", status: :see_other
  end

    private

    def set_song
      @song = Song.find(params[:id])
    end

    def song_params
      params.require(:song).permit(:name, :artist_name, :uri, :manual_uri, :image, :correct_info)
    end
end
