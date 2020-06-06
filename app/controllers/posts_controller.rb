class PostsController < ApplicationController

  before_action :ensure_correct_user, {only: [:edit, :update, :destroy]}
  before_action :authenticate_user!

  def index
    @posts_all = Post.includes(:user,:taggings,:like_users,:likes)

    @user = User.find(current_user.id)

    @follow_users = @user.following_user.all

    @posts = Post.where(user_id: @follow_users).order("created_at DESC").page(params[:page]).per(10)
  end

  def index2
    @posts_all = Post.includes(:user,:taggings,:like_users,:likes)

    @user = User.find(current_user.id)

    @follow_users = @user.following_user.all

    @likes = Like.where(user_id: @follow_users).order("created_at DESC").page(params[:page]).per(10)
  end

  def show
    @post = Post.find_by(id: params[:id])
    @user = @post.user
    @likes_count = Like.where(post_id: @post.id).count
    @likes_user_count = Like.where(user_id: current_user.id).count
  end

  def new
      @post = Post.new
  end

  def create
    @post = Post.new(content: params[:content], user_id: current_user.id)
    if @post.save
      flash[:notice] = "投稿を作成しました"
      redirect_to("/posts/index")
    else
      render("posts/new")
    end
  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def update
    @post = Post.find_by(id: params[:id])
    @post.content = params[:content]
    if @post.save
      flash[:notice] = "投稿を編集しました"
      redirect_to("/posts/index")
    else
      render("posts/edit")
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to("/posts/index")
  end

  def ensure_correct_user
    @post = Post.find_by(id: params[:id])
    if @post.user_id != current_user.id
      flash[:notice] = "権限がありません"
      redirect_to("/posts/index")
    end
  end
end
