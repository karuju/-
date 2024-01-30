class TopController < ApplicationController
  skip_before_action :require_login, only: %i[ index ]

  def index
    @boards = Board.order(created_at: :desc).limit(3)
    @posts = Post.order(created_at: :desc).limit(3)
  end

  def create_post
    session[:creation_type] = 'post'
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

  def privacy_policy
  end

  def terms
  end

end
