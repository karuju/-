class NovelsController < ApplicationController
  require 'rakuten_web_service'
  def index
  end

  def new
    @novel = Novel.new
    @song = Song.find(session[:song_id])
  end


  def show
    @novel = Novel.find(params[:id])
  end

  def create
    @novel = Novel.find_or_initialize_by(novel_params)
    @song = Song.find(session[:song_id])

    if @novel.new_record?
      @books = RakutenWebService::Books::Book.search(title: novel_params[:title], author: novel_params[:author])
      book = @books.first
      @novel.summary = book['itemCaption']
      @novel.uri = book['itemUrl']
      @novel.publisher = book['publisherName']
    end
    if @novel.save
      session[:novel_id] = @novel.id
      set_redirect_path
    else
      flash[:danger] = "保存できませんでした"
      redirect_to contents_new_path, status: :see_other
    end
  end

  private
  def novel_params
    params.require(:novel).permit(:title, :author, :category, :summary, :uri, :publisher, :published_year)
  end

  def set_redirect_path
    if session[:creation_type] == 'answer'
      redirect_to new_board_answer_path(session[:board_id], @novel)
    else
      redirect_to new_post_path(@novel)
    end
  end

end
