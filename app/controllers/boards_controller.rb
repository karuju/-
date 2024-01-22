class BoardsController < ApplicationController
  before_action :set_board, only: %i[ show edit update destroy ]
  skip_before_action :require_login, only: %i[ index show ]


  # GET /boards or /boards.json
  def index
    @q = Board.ransack(params[:q])
    @boards = @q.result(distinct: true).includes(:song).page(params[:page]).order(created_at: :desc)
    #@boards = Board.all.order(created_at: :desc).page(params[:page])
  end

  # GET /boards/1 or /boards/1.json
  def show
    @song = Song
  end

  # GET /boards/new
  def new
    @board = Board.new
    @song = Song.find(session[:song_id])
  end

  # GET /boards/1/edit
  def edit
  end

  # POST /boards or /boards.json
  def create
    @board = current_user.boards.new(title: params[:board][:title], body: params[:board][:body], song_id:params[:board][:song_id])
    
    respond_to do |format|
      if @board.save
        
        format.html { redirect_to board_url(@board), notice: "Board was successfully created." }
        format.json { render :show, status: :created, location: @board }
      else
        @song = Song.find(session[:song_id])
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @board.errors, status: :unprocessable_entity }
      end
    end
    session[:song_id] = nil
  end

  # PATCH/PUT /boards/1 or /boards/1.json
  def update
    respond_to do |format|
      if @board.update(board_params)
        format.html { redirect_to board_url(@board), notice: "Board was successfully updated." }
        format.json { render :show, status: :ok, location: @board }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @board.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /boards/1 or /boards/1.json
  def destroy
    @board.destroy

    respond_to do |format|
      format.html { redirect_to boards_url, notice: "Board was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_board
      @board = Board.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def board_params
      params.require(:post).permit(:title, :body, :song_id)
    end
end
