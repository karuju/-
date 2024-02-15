class AnswersController < ApplicationController
  before_action :set_answer, only: %i[ show edit update destroy ]
  skip_before_action :require_login, only: %i[ index show ]
  include SetSessionService
  # GET /answers or /answers.json
  def index
    @answers = Answer.page(3)
  end

  def save_session
    session[:creation_type] = 'answer'
    session[:board_id] = params[:board_id] #answerはboardにネストしたルーティングにしているから通常は不要。今回は行程が通常より多いからsessionに保村
    redirect_to contents_new_path
  end
  # GET /answers/1 or /answers/1.json
  def show
    @answer = Answer.find(params[:id])
  end

  # GET /answers/new
  def new
    @board = Board.find(params[:board_id])
    @answer = @board.answers.build
    @song = Song.find(session[:song_id])
    set_session
  end

  # GET /answers/1/edit
  def edit
    @board = @answer.board
  end

  # POST /answers or /answers.json
  def create
    @board = Board.find(params[:board_id])
    @answer = current_user.answers.new(answer_params)
    @answer.board = @board
    @song = @board.song
      if @answer.save
        if session[:comic_id]
          Content.create!(answer_id: @answer.id, contentable_id:session[:comic_id], contentable_type: 'Comic')
        elsif session[:novel_id]
          Content.create!(answer_id: @answer.id, contentable_id:session[:novel_id], contentable_type: 'Novel')
        elsif session[:movie_id]
          Content.create!(answer_id: @answer.id, contentable_id:session[:movie_id], contentable_type: 'Movie')
        elsif session[:anime_id]
          Content.create!(answer_id: @answer.id, contentable_id:session[:anime_id], contentable_type: 'Anime')
        elsif session[:game_id]
          Content.create!(answer_id: @answer.id, contentable_id:session[:game_id], contentable_type: 'Game')
        end

        redirect_to board_path(@board), success: "回答しました" 
        clear_session
      else
        flash[:danger] = "回答できませんでした"
        render :new, status: :unprocessable_entity
      end
  end

  # PATCH/PUT /answers/1 or /answers/1.json
  def update
    @board = Board.find(params[:board_id])
    if @answer.update(answer_params)
      clear_session
      redirect_to board_path(@answer.board), success: "編集しました" 
    else
      flash[:danger] = "編集できませんでした"
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /answers/1 or /answers/1.json
  def destroy
    @answer.destroy
    redirect_to board_path(@answer.board), notice: "回答を削除しました" 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_answer
      @answer = Answer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def answer_params
      params.require(:answer).permit(:body, :content)
    end

    def clear_session
      session[:creation_type] = nil
      session[:song_id] = nil
      session[:board_id] = nil
      session[:comic_id] = nil
      session[:novel_id] = nil
      session[:movie_id] = nil
      session[:anime_id] = nil
      session[:game_id] = nil
    end
end
