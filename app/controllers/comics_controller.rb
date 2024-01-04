class ComicsController < ApplicationController
  def index
  end

  def new
    @comic = Comic.new
    @song = Song.find(session[:song_id])
  end

  def search
  end

  def show
    @comic = Comic.find(params[:id])
  end

  def create
    @comic = Comic.find_or_initialize_by(comic_params)
    if @comic.save
      session[:comic_id] = @comic.id
      redirect_to new_post_path(@comic)
    else
      render new
    end

  end

  def edit
    @comic = Comic.find_by(comic_params)
    if @comic.save
      session[:comic_id] = @comic.id
      #redirect_to new_post_path(@comic, @song)
    else
      render new
    end
  end

  def update
  end

  def destroy
  end

  private
  def comic_params
    params.require(:comic).permit(:title, :author, :category, :summary, :uri, :publisher, :published_year)
  end
end
