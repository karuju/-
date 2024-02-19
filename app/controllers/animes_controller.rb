class AnimesController < ApplicationController
  def new
    @anime = Anime.new
    @song = Song.find(session[:song_id])
  end

  def search; end

  def show
    @anime = Anime.find(params[:id])
  end

  def create
    @anime = Anime.find_or_initialize_by(anime_params)
    @song = Song.find(session[:song_id])
    if @anime.save
      session[:anime_id] = @anime.id
      set_redirect_path
    else
      flash[:danger] = "保存できませんでした"
      redirect_to contents_new_path, status: :see_other
    end
  end

  private
 
  def anime_params
    params.require(:anime).permit(:title, :creator, :category, :uri, :release_date)
  end

  def set_redirect_path
    if session[:creation_type] == 'answer'
      redirect_to new_board_answer_path(session[:board_id], @anime)
    else
      redirect_to new_post_path(@anime)
    end
  end
end
