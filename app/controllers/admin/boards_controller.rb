class Admin::BoardsController < ApplicationController
  before_action :set_board, only: %i[ show edit update destroy ]

  def index
    @q = Board.ransack(params[:q])
    @boards = @q.result(distinct: true).includes(:song).page(params[:page]).order(created_at: :desc)
  end

  def show
  end

  def edit
  end

  def update
    if @board.update(board_params)
      redirect_to admin_board_path(@board), success: "Boardの更新に成功しました"
    else
      flash[:danger] = "Boardの更新に失敗しました"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @board.destroy!
    redirect_to admin_boards_path, success: "削除しました", status: :see_other
  end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_board
      @board = Board.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def board_params
      params.require(:board).permit(:body, :song_id)
    end
end
