class Admin::GamesController < ApplicationController
  before_action :set_game, only: %i[show edit update destroy]
  def index
    @q = Game.ransack(params[:q])
    @games = @q.result(distinct: true).page(params[:page]).order(created_at: :desc)

  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @game.update(game_params)
        format.html { redirect_to admin_game_url(@game), notice: "game was successfully updated." }
        format.json { render :show, status: :ok, location: @game }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @game.destroy
    redirect_to admin_games_path, success: "削除しました", status: :see_other
  end

  private
  
    def set_game
      @game = Game.find(params[:id])
    end

    def game_params
      params.require(:game).permit(:title, :creator, :category, :uri, :release_date)
    end
end
