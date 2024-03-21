class Song < ApplicationRecord
  validates :name, presence: true
  belongs_to :artist
  has_many :posts
  has_many :boards

  # 楽曲検索
  def self.search(song_params)
    if song_params[:name].present? && song_params[:artist_name].present?
      artist = Artist.find_or_initialize_by(name: song_params[:artist_name])
      song = Song.find_or_initialize_by(name: song_params[:name], artist:)  
      # Spotifyから楽曲情報を取得
      if song.new_record?
        spotify_service = SpotifySearchService.new(artist_name: artist.name, song_name: song.name)
        spotify_result = spotify_service.search
        if spotify_result
          song.uri = spotify_result[:track].uri
          song.release_date = spotify_result[:track].album.release_date
          song.image = spotify_result[:track].album.images[0]['url']
        else
          # spotifyになければyoutubeを検索
          youtube_service = YoutubeSearchService.new
          youtube_result = youtube_service.search("#{song.name} #{song.artist.name} -カラオケ -歌ってみた -UTAU -ボーカロイド -ボカロ")
          song.uri = youtube_result[:video_id]
          song.image = youtube_result[:thumbnail_url]
        end
        return song
      else
        return song
      end
    end
  end

  # ransackでの検索に必要なメソッドふたつ
  def self.ransackable_attributes(auth_object = nil)
    %w[name]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[artist] # アソシエーション先を記述
  end
end
