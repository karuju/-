module SetSessionService
  extend ActiveSupport::Concern

  def set_session
    if session[:comic_id]
      @comic = Comic.find(session[:comic_id])
    elsif session[:novel_id]
      @novel = Novel.find(session[:novel_id])
    elsif session[:movie_id]
      @movie = Movie.find(session[:movie_id])
    elsif session[:anime_id]
      @anime = Anime.find(session[:anime_id])
    elsif session[:game_id]
      @game = Game.find(session[:game_id])
    end
  end
end