class ContentsController < ApplicationController
  def new
    if session[:board_id]
      @song = Board.find(session[:board_id]).song
      session[:song_id] = @song.id
    else
      @song = Song.find(session[:song_id])
      session[:song_id] = @song.id
    end
  end
end
