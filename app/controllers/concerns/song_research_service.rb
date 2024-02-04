module SongResearchService
  def self.research_by_url(song, artist, url, name)
    song.artist = artist

    if url.include?('open.spotify.com')
      track_id = url.split('/').last
      spotify_service = SpotifySearchService.new(track_id: track_id)
      spotify_result = spotify_service.research_by_url
      if spotify_result
        song.name = spotify_result[:track][:name]
        song.uri = spotify_result[:track][:uri]
        song.image = spotify_result[:track][:album].images[0]['url']
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
          song.name = name
          song.uri = youtube_result[:video_id]
          song.image = youtube_result[:thumbnail_url]
        end
      end
    else
      song.name = name
      song.uri = research_params[:manual_uri]
      song.image = ActionController::Base.helpers.asset_path('song_default.png')
    end

    song.save
    return song
  end
end