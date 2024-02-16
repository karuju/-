class ContentsController < ApplicationController
  def new
    if session[:board_id]
      @board = Board.find(session[:board_id])
      @song = @board.song
      session[:song_id] = @song.id
      #session[:board_id] = nil
    else
      @song = Song.find(session[:song_id])
      session[:song_id] = @song.id
    end
  end
end
