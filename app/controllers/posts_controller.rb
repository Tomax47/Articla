class PostsController < ApplicationController

  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :ensure_current_user
  before_action :correct_User, only: [:edit, :destroy, :update]

  def index
    @posts = Post.all.order("created_at DESC")
  end

  def new
    @post = current_user.posts.new
  end

  def create
    #@post = current_user.posts.new(post_params)
    @post = current_user.posts.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to post_url(@post), notice: "Post was successfully created!" }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end


  end


  def show
    @post = set_post
  end

  def edit
    @post = set_post
  end

  def update
    @post = current_user.posts.find(params[:id])

    if @post.update(post_params)
      redirect_to @post
      flash.now[:notice] = "Post Has Been Updated Successfully!"
    else
      redirect_to @post
      flash.now[:notice] = "Couldn't Update The Post!"
    end

  end

  def destroy
    @post = current_user.posts.find(params[:id])

    if @post.destroy
      redirect_to root_path
      flash.now[:notice] = "Post Has Been Deleted Successfully!"
    else
      redirect_to @post
      flash.now[:notice] = "Couldn't Delete The Post!"
    end
  end

  def correct_User
    @post = current_user.posts.find_by(id: params[:id])
    redirect_to posts_path, notice: "You are not authorized to edit this post!" if @post.nil?
  end


  private

  def set_post
    return Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content)
  end

end
