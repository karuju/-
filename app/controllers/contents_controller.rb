class ContentsController < ApplicationController
  def new
    @song = Song.find(session[:song_id])
  end
end
