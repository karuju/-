class TopController < ApplicationController
  def index
  end

  def create_post
    session[:creation_type] = 'post'
    #このセッションの活かし方
    redirect_to new_song_path
  end

  def create_board
    session[:creation_type] = 'board'
    redirect_to new_song_path
  end
end
