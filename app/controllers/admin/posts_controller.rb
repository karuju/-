class Admin::PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]

  def index
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true).includes(:song).page(params[:page]).order(created_at: :desc)
  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to admin_post_url(@post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy
    redirect_to admin_posts_path, success: "削除しました", status: :see_other
  end
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :song_id)
  end
end
