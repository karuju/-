class MoviesController < ApplicationController
  def index
  end

  def new
    @movie = Movie.new
    #@song = Song.find(session[:song_id])
  end

  def search
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      session[:movie_id] = @movie.id
      #redirect_to new_post_path(@movie)
    else
      render new
    end

  end

  def edit
    @movie = Movie.find_by(movie_params)
    if @movie.save
      session[:movie_id] = @movie.id
      #redirect_to new_post_path(@movie, @song)
    else
      render new
    end
  end

  def update
  end

  def destroy
  end

  private
  def movie_params
    params.require(:movie).permit(:title, :director, :leading_actor, :category, :summary, :uri,  :distributer, :published_year)
  end

end
