class Admin::AnswersController < ApplicationController
  before_action :set_answer, only: %i[ show edit update destroy ]
  def index
    @q = Answer.ransack(params[:q])
    @answers = @q.result(distinct: true).includes(:board).page(params[:page]).order(created_at: :desc)

  end

  def show
  end

  def edit
  end

  def update
    if @answer.update(answer_params)
      redirect_to admin_answer_path(@answer), success: "Answerの更新に成功しました"
    else
      flash[:danger] = "Answerの更新に失敗しました"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @answer.destroy!
    redirect_to admin_answers_path, success: "削除しました", status: :see_other
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


end
