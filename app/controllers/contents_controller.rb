class ContentsController < ApplicationController
  def new
    if session[:board_id]
      @board = Board.find(session[:board_id])
      @song = @board.song
    else
      @song = Song.find(session[:song_id])
    end
    session[:song_id] = @song.id
  end
end
