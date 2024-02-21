class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]
  skip_before_action :require_login, only: %i[index show]
  include SessionHandler

  def index
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true).includes(:song).page(params[:page]).order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
    @song = Song.find(session[:song_id])
    set_content
  end

  def edit; end

  def create
    @post = current_user.posts.new(body: params[:post][:body], song_id: params[:post][:song_id])
  
    ActiveRecord::Base.transaction do
      if @post.save
        create_content_for_post(@post)
        redirect_to post_url(@post), success: t('.create.success')
        clear_session
      else
        @song = Song.find(session[:song_id])
        set_content
        flash[:danger] = t('.create.false')
        render :new, status: :unprocessable_entity
      end
    end
  end

  def update
    if @post.update(post_params)
      redirect_to post_url(@post), success: t('.update.success')
    else
      flash[:danger] = t('.update.false')
      render :edit, status: :unprocessable_entity
     end
  end

  def destroy
    @post.destroy
    flash[:success] = t('.destroy.success')
    redirect_to posts_url, status: :see_other
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:body, :song_id)
  end

  def create_content_for_post(post)
    content_types = %w[comic novel movie anime game]
    content_types.each do |type|
      if session["#{type}_id"]
        Content.create!(post_id: post.id, contentable_id: session["#{type}_id"], contentable_type: type.capitalize)
        break
      end
    end
  end
end
