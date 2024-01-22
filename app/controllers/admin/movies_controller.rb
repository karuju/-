class Admin::MoviesController < ApplicationController
  before_action :set_movie, only: %i[show edit update destroy]
  def index
    @q = Movie.ransack(params[:q])
    @movies = @q.result(distinct: true).page(params[:page]).order(created_at: :desc)

  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @movie.update(comic_params)
        format.html { redirect_to admin_movie_url(@movie), notice: "Movie was successfully updated." }
        format.json { render :show, status: :ok, location: @movie }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @movie.destroy
    redirect_to admin_movies_path, success: "削除しました", status: :see_other
  end

  private
  
    def set_movie
      @movie = Movie.find(params[:id])
    end

    def comic_params
      params.require(:movie).permit(:title, :author, :category, :summary, :uri, :publisher, :published_year)
    end
end
