class ContentsController < ApplicationController
  def new
    if session[:board_id]
      @song = Board.find(session[:board_id]).song
    else
      @song = Song.find(session[:song_id])
    end
  end
end
