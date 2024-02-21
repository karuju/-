class AnswersController < ApplicationController
  before_action :set_answer, only: %i[show edit update destroy]
  skip_before_action :require_login, only: %i[index show]
  include SessionHandler
  # GET /answers or /answers.json
  def index
    @answers = Answer.page(3)
  end

  def save_session
    session[:creation_type] = 'answer'
    session[:board_id] = params[:board_id] # answerはboardにネストしたルーティングにしているから通常は不要。今回は行程が通常より多いからsessionに保存
    redirect_to contents_new_path
  end

  def show
    @answer = Answer.find(params[:id])
  end

  def new
    @board = Board.find(params[:board_id])
    @answer = @board.answers.build
    @song = Song.find(session[:song_id])
    set_content
  end

  def edit
    @board = @answer.board
  end

  def create
    @board = Board.find(params[:board_id])
    @answer = current_user.answers.new(answer_params)
    @answer.board = @board
    @song = @board.song
    ActiveRecord::Base.transaction do
      if @answer.save
        create_content_for_answer(@answer)
        redirect_to board_path(@board), success: "回答しました"
        clear_session
      else
        flash[:danger] = "回答できませんでした"
        render :new, status: :unprocessable_entity
      end
    end
  end

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

  def destroy
    @answer.destroy
    redirect_to board_path(@answer.board), notice: "回答を削除しました"
  end

  private

  def set_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body, :content)
  end

  def create_content_for_answer(answer)
    content_types = %w[comic novel movie anime game]
    content_types.each do |type|
      if session["#{type}_id"]
        Content.create!(answer_id: answer.id, contentable_id: session["#{type}_id"], contentable_type: type.capitalize)
        break
      end
    end
  end
end