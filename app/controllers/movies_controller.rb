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
    @movie = Movie.find_or_initialize_by(movie_params)
    @song = Song.find(session[:song_id])
    if @movie.save
      session[:movie_id] = @movie.id
      set_redirect_path
    else
      flash[:danger] = "保存できませんでした"
      redirect_to contents_new_path, status: :see_other
    end

  end

  def edit
    @movie = Movie.find_by(movie_params)
    if @movie.save
      session[:movie_id] = @movie.id
      redirect_to new_post_path(@movie, @song)
    else
      flash[:danger] = "編集できませんでした"
      render new, status: :unprocessable_entity
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

  def set_redirect_path
    if session[:creation_type] == 'answer'
      redirect_to new_board_answer_path(session[:board_id], @movie)
    else
      redirect_to new_post_path(@movie)
    end
  end

end
