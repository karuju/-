class Admin::AnimesController < ApplicationController
    before_action :set_anime, only: %i[show edit update destroy]
  def index
    @q = Anime.ransack(params[:q])
    @animes = @q.result(distinct: true).page(params[:page]).order(created_at: :desc)

  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @anime.update(anime_params)
        format.html { redirect_to admin_anime_url(@anime), notice: "anime was successfully updated." }
        format.json { render :show, status: :ok, location: @anime }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @anime.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @anime.destroy
    redirect_to admin_animes_path, success: "削除しました", status: :see_other
  end

  private
  
    def set_anime
      @anime = Anime.find(params[:id])
    end

    def anime_params
      params.require(:anime).permit(:title, :creator, :category, :uri, :release_date)
    end
end
