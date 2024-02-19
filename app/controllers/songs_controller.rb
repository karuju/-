class SongsController < ApplicationController
  def index; end

  def new
    @song = Song.new
  end

  def search
    @song = Song.search(song_params)
    if @song
      render "search"
    else
      flash[:danger] = "検索できませんでした"
      redirect_to new_song_path, status: :see_other
    end
  end

  def research_by_url
    artist = Artist.find_or_initialize_by(name: song_params[:artist_name])
    @song = Song.find_or_initialize_by(name: research_params[:name], artist:)
    url = research_params[:manual_uri]
    name = research_params[:name]
    @song.artist = artist

    @song = SongResearchService.research_by_url(@song, artist, url, name)

    session[:song_id] = @song.id
    redirect_based_on_creation_type(@song)
  end

  def show
    @song = Song.find(params[:id])
  end

  def create
    artist = Artist.find_or_initialize_by(name: song_params[:artist_name])
    @song = Song.find_or_initialize_by(name: song_params[:name], artist:, image: song_params[:image])
    
    if @song.new_record?
      @song.uri = params[:song][:uri]
      if @song.save
        session[:song_id] = @song.id
        redirect_based_on_creation_type(@song)
      else
        flash[:danger] = "保存できませんでした"
        render new, status: :unprocessable_entity
      end
    else
    end
  end

  def edit; end

  def update
    artist = Artist.find_by(name: song_params[:artist_name])
    @song = Song.find_by(name: song_params[:name], artist:)
    if song_params[:correct_info] == '1'
      @song.uri = params[:song][:uri]
    else
      @song.uri = params[:song][:manual_uri]
    end
    session[:song_id] = @song.id
    redirect_based_on_creation_type(@song)
  end

  def destroy; end

  private

  def song_params
    params.require(:song).permit(:name, :artist_name, :uri, :manual_uri, :image, :correct_info)
  end

  def research_params
    params.require(:song).permit(:manual_uri, :artist_name, :name)
  end

  def redirect_based_on_creation_type(song)
    if session[:creation_type] == 'post'
      redirect_to contents_new_path(song)
    elsif session[:creation_type] == 'board'
      redirect_to new_board_path(song)
    end
  end
end
