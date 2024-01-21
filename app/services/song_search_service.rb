class SongSearchService
  #Songs#createから分けるかも
=begin
  def initialize(song)
    @song = song
  end

  def execute
    spotify_service = SpotifySearchService.new(@song.artist.name, @song.name)
    spotify_result = spotify_service.search

    if spotify_result
      @song.uri = spotify_result[:track].uri
      @song.release_date = spotify_result[:track].album.release_date
      @song.image = spotify_result[:track].album.images[0]['url']
    else
      youtube_service = YoutubeSearchService.new
      youtube_result = youtube_service.search("#{@song.name} #{@song.artist.name} -カラオケ -歌ってみた")
      @song.uri = youtube_result[:video_id]
      @song.image = youtube_result[:thumbnail_url]
    end

    @song.save
  end
=end
end
