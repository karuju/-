class TopController < ApplicationController
  skip_before_action :require_login, only: %i[index]

  def index
    random_board
    random_post
  end

  def privacy_policy; end

  def terms; end

  private

  def random_board
    @board = Board.order("RAND()").first
  end

  def random_post
    @post = Post.order("RAND()").first
  end
end
