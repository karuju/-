class SongsController < ApplicationController
  def index
  end

  def new
    @song = Song.new
  end

  
  def search
    artist = Artist.find_or_initialize_by(name: song_params[:artist_name])
    @song = Song.find_or_initialize_by(name: song_params[:name], artist: artist)  
      
    # Spotifyから楽曲情報を取得
    if @song.new_record?
      spotify_service = SpotifySearchService.new(artist_name: artist.name, song_name: @song.name)
      spotify_result = spotify_service.search
  
      if spotify_result
        @song.uri = spotify_result[:track].uri
        @song.release_date = spotify_result[:track].album.release_date
        @song.image = spotify_result[:track].album.images[0]['url'] #spotifyに見つからない時の
      else
      #spotifyになければyoutubeを検索
        youtube_service = YoutubeSearchService.new
        youtube_result = youtube_service.search("#{@song.name} #{@song.artist.name} -カラオケ -歌ってみた -UTAU -ボーカロイド -ボカロ")
        @song.uri = youtube_result[:video_id]
        @song.image = youtube_result[:thumbnail_url]
      end
    else
    end
  
    search_result = @song.uri
  
  end

  def research_by_url
    url = research_params[:manual_uri]
    @song = Song.new
    name = research_params[:name]
    artist = Artist.find_or_initialize_by(name: song_params[:artist_name])
    @song.artist = artist
    if url.include?('open.spotify.com')
      track_id = url.split('/').last
      spotify_service = SpotifySearchService.new(track_id: track_id)
      spotify_result = spotify_service.research_by_url
      if spotify_result
        @song.name = spotify_result[:track][:name]
        @song.uri = spotify_result[:track][:uri]
        @song.image = spotify_result[:track][:album].images[0]['url']
      end
    elsif url.include?('youtube.com') || url.include?('youtu.be')
      if url.include?('youtube.com')
        video_id = url.match(/(?:\?|&)v=([^&]+)/)[1]
      elsif url.include?('youtu.be')
        video_id = url.split('/').last.split('?').first
      end 
      if video_id
        youtube_service = YoutubeSearchService.new
        youtube_result = youtube_service.research_by_url(video_id)
        if youtube_result
          @song.name = name
          @song.uri = youtube_result[:video_id]
          @song.image = youtube_result[:thumbnail_url]
        end
      end
    else
      @song.name = name
      @song.uri = research_params[:manual_uri]
      @song.image = ActionController::Base.helpers.asset_path('song_default.png')
    end

    @song.save
    session[:song_id] = @song.id
    redirect_based_on_creation_type(@song)
  end

  def show
    @song = Song.find(params[:id])
  end

  def create
    artist = Artist.find_or_initialize_by(name: song_params[:artist_name])
    @song = Song.find_or_initialize_by(name: song_params[:name], artist: artist, image: song_params[:image])
    
    if @song.new_record?
      if song_params[:correct_info] == '1'
        @song.uri = params[:song][:uri]
      else
        @song.uri = params[:song][:manual_uri]
      end

      if @song.save
        session[:song_id] = @song.id
        redirect_based_on_creation_type(@song)
      else
        render new
      end
    else
    end
    #session[:song_id] = @song.id
    #redirect_to song_path(@song)
  end

  def edit
  end

  def update
    artist = Artist.find_by(name: song_params[:artist_name])
    @song = Song.find_by(name: song_params[:name], artist: artist, image: song_params[:image])
    if song_params[:correct_info] == '1'
      @song.uri = params[:song][:uri]
    else
      @song.uri = params[:song][:manual_uri]
    end
    session[:song_id] = @song.id
    redirect_based_on_creation_type(@song)
  end

  def destroy
  end

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
