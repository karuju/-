module SessionHandler
  extend ActiveSupport::Concern

  def set_content
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

  def clear_session
    session[:creation_type] = nil
    session[:song_id] = nil
    session[:board_id] = nil
    session[:comic_id] = nil
    session[:novel_id] = nil
    session[:movie_id] = nil
    session[:anime_id] = nil
    session[:game_id] = nil
  end
end
