class Admin::ComicsController < ApplicationController
  before_action :set_comic, only: %i[show edit update destroy]
  def index
    @q = Comic.ransack(params[:q])
    @comics = @q.result(distinct: true).page(params[:page]).order(created_at: :desc)

  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @comic.update(comic_params)
        format.html { redirect_to admin_comic_url(@comic), notice: "Comic was successfully updated." }
        format.json { render :show, status: :ok, location: @comic }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @comic.destroy
    redirect_to admin_comics_path, success: "削除しました", status: :see_other
  end

  private
  
    def set_comic
      @comic = Comic.find(params[:id])
    end

    def comic_params
      params.require(:comic).permit(:title, :author, :category, :summary, :uri, :publisher, :published_year)
    end
end
