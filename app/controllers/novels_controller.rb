class NovelsController < ApplicationController
  def index
  end

  def new
    @novel = Novel.new
    @song = Song.find(session[:song_id])
  end

  def search
  end

  def show
    @novel = Novel.find(params[:id])
  end

  def create
    @novel = Novel.find_or_initialize_by(novel_params)
    if @novel.save
      session[:novel_id] = @novel.id
      redirect_to new_post_path(@novel)
    else
      render new
    end

  end

  def edit
    @novel = Novel.find_by(novel_params)
    if @novel.save
      session[:novel_id] = @novel.id
      #redirect_to new_post_path(@novel, @song)
    else
      render new
    end
  end

  def update
  end

  def destroy
  end

  private
  def novel_params
    params.require(:novel).permit(:title, :author, :category, :summary, :uri, :publisher, :published_year)
  end

end
