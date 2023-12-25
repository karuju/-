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
      spotify_service = SpotifySearchService.new(artist.name, @song.name)
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
  #モーダルウィンドウでの表示(できてない)
=begin
    respond_to do |format|
      format.html { render 'songs/search_result.html.turbo_stream.erb', locals: { uri: @song.uri, imgae_url: @song.image }, layout: false}
      format.json { render json: {uri: uri, image_url: image_url} }
    end
=end
  
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
        redirect_to song_path(@song)
      else
        render new
      end
    else
       redirect_to song_path(@song)
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def song_params
    params.require(:song).permit(:name, :artist_name, :uri, :manual_uri, :image, :correct_info)
  end


end
