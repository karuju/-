class GamesController < ApplicationController
  def new
    @game = Game.new
    @song = Song.find(session[:song_id])
  end

  def search; end

  def show
    @game = Game.find(params[:id])
  end

  def create
    @game = Game.find_or_initialize_by(game_params)
    @song = Song.find(session[:song_id])
    if @game.save
      session[:game_id] = @game.id
      set_redirect_path
    else
      flash[:danger] = "保存できませんでした"
      redirect_to contents_new_path, status: :see_other
    end
  end

  private

  def game_params
    params.require(:game).permit(:title, :creator, :category, :uri, :release_date)
  end

  def set_redirect_path
    if session[:creation_type] == 'answer'
      redirect_to new_board_answer_path(session[:board_id], @game)
    else
      redirect_to new_post_path(@game)
    end
  end
end
