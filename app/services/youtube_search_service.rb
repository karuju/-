class YoutubeSearchService
  def initialize
    @youtube = Google::Apis::YoutubeV3::YouTubeService.new
    @youtube.key = ENV['GOOGLE_API_KEY']
  end

  def search(query)
    search_response = @youtube.list_searches('id,snippet', q: query, max_results: 1, type: 'video')
    video_id = search_response.items.first.id.video_id
    thumbnail_url = search_response.items.first.snippet.thumbnails.medium.url
    return { video_id: video_id, thumbnail_url: thumbnail_url}
  end

  def research_by_url(video_id)
    search_response = @youtube.list_videos('snippet', id: video_id)
    thumbnail_url = search_response.items[0].snippet.thumbnails.medium.url
    return { video_id: video_id, thumbnail_url: thumbnail_url}
  end
end