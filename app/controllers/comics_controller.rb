class ComicsController < ApplicationController
  def index
  end

  def new
    @comic = Comic.new
    @song = Song.find(session[:song_id])
  end

  def search
  end

  def show
    @comic = Comic.find(params[:id])
  end

  def create
    @comic = Comic.find_or_initialize_by(comic_params)
    @song = Song.find(session[:song_id])
    if @comic.save
      session[:comic_id] = @comic.id
      set_redirect_path
    else
      flash[:danger] = "保存できませんでした"
      redirect_to contents_new_path, status: :see_other
    end

  end

  def edit
    @comic = Comic.find_by(comic_params)
    if @comic.save
      session[:comic_id] = @comic.id
      #redirect_to new_post_path(@comic, @song)
    else
      flash[:danger] = "編集できませんでした"
      render new, status: :unprocessable_entity
    end
  end

  def update
  end

  def destroy
  end

  private
  def comic_params
    params.require(:comic).permit(:title, :author, :category, :summary, :uri, :publisher, :published_year)
  end

  def set_redirect_path
    if session[:creation_type] == 'answer'
      redirect_to new_board_answer_path(session[:board_id], @comic)
    else
      redirect_to new_post_path(@comic)
    end
  end
end
