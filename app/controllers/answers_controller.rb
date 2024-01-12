class AnswersController < ApplicationController
  before_action :set_answer, only: %i[ show edit update destroy ]
  before_action :require_login, only: %i[ save_session new create edit update destroy ]

  # GET /answers or /answers.json
  def index
    @answers = Answer.all
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
    @song = @board.song
    if session[:comic_id]
      @comic = Comic.find(session[:comic_id])
    elsif session[:novel_id]
      @novel = Novel.find(session[:novel_id])
    elsif session[:movie_id]
      @movie = Movie.find(session[:movie_id])
    end
  end

  # GET /answers/1/edit
  def edit
  end

  # POST /answers or /answers.json
  def create
    @board = Board.find(params[:board_id])
    @answer = current_user.answers.new(answer_params)
    @answer.board = @board

    respond_to do |format|
      if @answer.save
        format.html { redirect_to board_path(@board), notice: "Answer was successfully created." }
        format.json { render :show, status: :created, location: @answer }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /answers/1 or /answers/1.json
  def update
    respond_to do |format|
      if @answer.update(answer_params)
        clear_session
        format.html { redirect_to answer_url(@answer), notice: "Answer was successfully updated." }
        format.json { render :show, status: :ok, location: @answer }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /answers/1 or /answers/1.json
  def destroy
    @answer.destroy

    respond_to do |format|
      format.html { redirect_to answers_url, notice: "Answer was successfully destroyed." }
      format.json { head :no_content }
    end
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
    end
end
