class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  skip_before_action :require_login, only: %i[ index show ]

  # GET /posts or /posts.json
  def index
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true).includes(:song).page(params[:page]).order(created_at: :desc)

    #@posts = Post.all.order(craeated_at: :desc).page(params[:page])
  end

  # GET /posts/1 or /posts/1.json
  def show
    @post = Post.find(params[:id])
    
  end

  # GET /posts/new
  def new
    @post = Post.new
  
    @song = Song.find(session[:song_id])
    if session[:comic_id]
    @comic = Comic.find(session[:comic_id])
    elsif session[:novel_id]
    @novel = Novel.find(session[:novel_id])
    elsif session[:movie_id]
    @movie = Movie.find(session[:movie_id])
    end

  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = current_user.posts.new(body: params[:post][:body], song_id: params[:post][:song_id])
    if @post.save
      if session[:comic_id]
        Content.create!(post_id: @post.id, contentable_id:session[:comic_id], contentable_type: 'Comic')
      elsif session[:novel_id]
        Content.create!(post_id: @post.id, contentable_id:session[:novel_id], contentable_type: 'Novel')
      elsif session[:movie_id]
        Content.create!(post_id: @post.id, contentable_id:session[:movie_id], contentable_type: 'Movie')
      end
      redirect_to post_url(@post), success: t('.create.success')
      clear_session
    else
      @song = Song.find(session[:song_id])
      set_content
      flash[:danger] = t('.create.false')
      render :new, status: :unprocessable_entity 
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    if @post.update(post_params)
      redirect_to post_url(@post), success: t('.update.success')
    else
      flash[:danger] = t('.update.false')
      render :edit, status: :unprocessable_entity
     end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy
    flash[:success] = t('.destroy.success')
    redirect_to posts_url, status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    def set_content
      if session[:comic_id]
        @comic = Comic.find(session[:comic_id])
      elsif session[:novel_id]
        @novel = Novel.find(session[:novel_id])
      elsif session[:movie_id]
        @movie = Movie.find(session[:movie_id])
      end
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:body, :song_id)
    end

    def clear_session
      session[:creation_type] = nil
      session[:song_id] = nil
      session[:board_id] = nil
      session[:comic_id] = nil
      session[:novel_id] = nil
      session[:movie_id] = nil
    end
end
