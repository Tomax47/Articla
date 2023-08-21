class PostsController < ApplicationController
  def index
    @posts = Post.all.order("created_at DESC")
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to @post
      flash.now[:notice] = "Post Has Been Created!"
    else
      render 'new'
      flash[:notice] = "Couldn't Create The Post!"
    end
  end


  def show
    set_post
  end

  def edit
    set_post
  end

  def update
    set_post
    if @post.update(post_params)
      redirect_to @post
      flash.now[:notice] = "Post Has Been Updated Successfully!"
    else
      redirect_to @post
      flash.now[:notice] = "Couldn't Update The Post!"
    end
  end

  def destroy
    @post = Post.find(params[:id])

    if @post.destroy
      redirect_to root_path
      flash.now[:notice] = "Post Has Been Deleted Successfully!"
    else
      redirect_to @post
      flash.now[:notice] = "Couldn't Delete The Post!"
    end
  end


  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content)
  end

end
