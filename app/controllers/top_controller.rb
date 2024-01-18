class TopController < ApplicationController
  before_action :require_login, only: %i[ create_post create_board create_answer ]

  def index
    @boards = Board.order(created_at: :desc).limit(3)
    @boards = Board.order(created_at: :desc).limit(3)
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

  def create_answer
    session[:creation_type] = 'answer'
    redirect_to contents_new_path
  end

end
