class ContentsController < ApplicationController
  before_action :set_creation_type, only: %i[new]
  def new
    if session[:board_id]
      @board = Board.find(session[:board_id])
      @song = @board.song
    else
      @song = Song.find(session[:song_id])
    end
    session[:song_id] = @song.id
  end

  private

  def set_creation_type
    session[:creation_type] = params[:creation_type] if params[:creation_type].present?
    session[:board_id] = params[:board_id] if params[:board_id].present?
  end
end
