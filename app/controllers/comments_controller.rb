class CommentsController < ApplicationController


  def new
    @post = Post.find(params[post_id])
    @comment = @post.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)

    if @comment.save
      redirect_to @post
      flash.now[:notice] = "Comment Has Been Added!"
    else
      render 'new'
      flash.now[:notice] = "Couldn't Add The Comment!"
    end
  end


  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])

    if @comment.destroy
      redirect_to @post
      flash.now[:notice] = "Comment Has Been Deleted!"
    else
      flash.now[:notice] = "Couldn't Delete The Comment!"
    end
  end


  private

  def comment_params
    params.require(:comment).permit(:title, :body)
  end
end
