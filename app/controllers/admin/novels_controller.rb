class Admin::NovelsController < ApplicationController
  before_action :set_novel, only: %i[show edit update destroy]
  def index
    @q = Novel.ransack(params[:q])
    @novels = @q.result(distinct: true).page(params[:page]).order(created_at: :desc)

  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @novel.update(comic_params)
        format.html { redirect_to admin_novel_url(@novel), notice: "Novel was successfully updated." }
        format.json { render :show, status: :ok, location: @novel }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @novel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @novel.destroy
    redirect_to admin_novels_path, success: "削除しました", status: :see_other
  end

  private
  
    def set_novel
      @novel = Novel.find(params[:id])
    end

    def comic_params
      params.require(:novel).permit(:title, :author, :category, :summary, :uri, :publisher, :published_year)
    end
end
