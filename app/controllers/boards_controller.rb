class BoardsController < ApplicationController
  before_action :set_board, only: %i[ show change_status edit update destroy ]
  skip_before_action :require_login, only: %i[ index show ]


  # GET /boards or /boards.json
  def index
    @q = Board.ransack(params[:q])
    @boards = @q.result(distinct: true).includes(:song).page(params[:page]).order(created_at: :desc)
  end

  # GET /boards/1 or /boards/1.json
  def show
  end

  # GET /boards/new
  def new
    @board = Board.new
    @song = Song.find(session[:song_id])
  end

  def change_status
    @board.update(status: 1)
    redirect_to board_path(@board)
  end

  # GET /boards/1/edit
  def edit
  end

  # POST /boards or /boards.json
  def create
    @board = current_user.boards.new(title: params[:board][:title], body: params[:board][:body], song_id:params[:board][:song_id])
    if @board.save
      redirect_to board_url(@board), success: t('.create.success')
    else
      @song = Song.find(session[:song_id])
      flash[:danger] = t('.create.false')
      render :new, status: :unprocessable_entity
    end
    session[:song_id] = nil
  end

  # PATCH/PUT /boards/1 or /boards/1.json
  def update
    if @board.update(board_params)
      redirect_to board_url(@board), success: t('.update.success')
    else
      flash[:danger] = t('.update.false')
      render :edit, status: :unprocessable_entity 
    end
  end

  # DELETE /boards/1 or /boards/1.json
  def destroy
    @board.destroy
    flash[:success] = t('.destroy.success')
    redirect_to boards_url, status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_board
      @board = Board.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def board_params
      params.require(:board).permit(:title, :body, :song_id)
    end
end
