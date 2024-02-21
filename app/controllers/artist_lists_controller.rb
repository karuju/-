class ArtistListsController < ApplicationController
  before_action :require_login
  def index
    @artists = current_user.artists.includes(:artist_lists)
    @artist_list = @artists.map do |artist|
      current_user.artist_lists.find_by(artist_id: artist.id)
    end
  end

  def create
    @artist = Artist.find(params[:artist_id])
    # @post = Post.find(params[:post_id])
    item_type = params[:item_type].constantize
    @item = item_type.find(params[:item_id])
    current_user.add_to_artist_list(@artist)
  end

  def destroy
    artist_list = current_user.artist_lists.find(params[:id])
    @artist = Artist.find(artist_list.artist_id)
    current_user.remove_from_artist_list(@artist)
    redirect_to artist_lists_users_path, success: "アーティストリストから削除しました", status: :see_other
  end

  def show
    @artist = Artist.find(params[:id])
    songs = Song.includes(:boards, :posts).where(artist_id: @artist.id)
    @boards = songs.map(&:boards).flatten
    @posts = songs.map(&:posts).flatten
  end
end
