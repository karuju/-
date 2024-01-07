class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :require_login, only: %i[ new create edit update destroy ]

  # GET /posts or /posts.json
  def index
    @posts = Post.all
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
    @post = Post.new(title: params[:post][:title], content: params[:post][:content])

    respond_to do |format|
      if @post.save
        PostSong.create!(post_id: @post.id, song_id: params[:post][:song_id]) # PostSongを作成
        if session[:comic_id]
        Content.create!(post_id: @post.id, contentable_id:session[:comic_id], contentable_type: 'Comic')
        elsif session[:novel_id]
          Content.create!(post_id: @post.id, contentable_id:session[:novel_id], contentable_type: 'Novel')
        elsif session[:movie_id]
        Content.create!(post_id: @post.id, contentable_id:session[:movie_id], contentable_type: 'Movie')
        end
        format.html { redirect_to post_url(@post), notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
        session[:song_id] = nil
        session[:comic_id] = nil
        session[:novel_id] = nil
        session[:movie_id] = nil
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
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

    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :content, :song_id)
    end

end
