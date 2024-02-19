class BoardsController < ApplicationController
  before_action :set_board, only: %i[show change_status edit update destroy]
  skip_before_action :require_login, only: %i[index show]

  def index
    @q = Board.ransack(params[:q])
    @boards = @q.result(distinct: true).includes(:song).page(params[:page]).order(created_at: :desc)
  end

  def show
    @answers = @board.answers.page(3)
  end

  def new
    @board = Board.new
    @song = Song.find(session[:song_id])
  end

  def change_status
    @board.update(status: 1)
    redirect_to board_path(@board)
  end

  def edit; end

  def create
    @board = current_user.boards.new(body: params[:board][:body], song_id: params[:board][:song_id])
    if @board.save
      redirect_to board_url(@board), success: t('.create.success')
    else
      @song = Song.find(session[:song_id])
      flash[:danger] = t('.create.false')
      render :new, status: :unprocessable_entity
    end
    session[:song_id] = nil
  end

  def update
    if @board.update(board_params)
      redirect_to board_url(@board), success: t('.update.success')
    else
      flash[:danger] = t('.update.false')
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @board.destroy
    flash[:success] = t('.destroy.success')
    redirect_to boards_url, status: :see_other
  end

  private

  def set_board
    @board = Board.find(params[:id])
  end

  def board_params
    params.require(:board).permit(:body, :song_id)
  end
end
