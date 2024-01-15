class ArtistListsController < ApplicationController
  before_action :require_login
  def index
    @artists = current_user.artists
  end

  def create
    @artist = Artist.find(params[:artist_id])
    @post = Post.find(params[:post_id])
    current_user.add_to_artist_list(@artist)
    flash[:success] = "アーティストリストに登録しました"
    redirect_to post_path(@post)
  end

  def destroy
    @artist = current_user.artist_lists.find(params[:id])
    @post = Post.find(params[:post_id])
    current_user.remove_from_artist_list(@artist)
    redirect_to post_path(@post), success: "アーティストリストから削除しました", status: :see_other
  end
end
