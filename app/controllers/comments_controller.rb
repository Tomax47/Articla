class CommentsController < ApplicationController

  before_action :correct_User, only: [:destroy]

  def new
    @comment = current_user.comments.new
  end
  def create

    @comment = current_user.comments.new(comment_params)
    @comment.title = current_user.username

    if @comment.save
      redirect_to post_comments_url
    else
      flash[:notice] = @comment.errors.full_messages.to_sentence
    end

  end


  def destroy
    @comment = current_user.comments.find(params[:id])

    if @comment.destroy
      redirect_to post_comments_url
      flash.now[:notice] = "Comment has been deleted!"
    else
      flash[:notice] = @comment.errors.full_messages.to_sentence
    end
  end



  private

  def correct_User
    @comment = current_user.comments.find_by(id: params[:id])
    redirect_to post_comments_url, notice: "You are not authorized to delete this comment!" if @comment.nil?
  end

  def comment_params
    # The post_id is passed with the params, thus we will have to merge it with the comment's params
    params
      .require(:comment)
      .permit(:title, :body)
      .merge(post_id: params[:post_id])

  end
end


# OLD CREATE DEF
#def create
#     @post = Post.find(params[:post_id])
#     @comment = @post.comments.create(comment_params.merge(user_id: current_user.id))
#
#     if @comment.save
#      redirect_to @post,
#      status: :created,
#      notice: 'Comment created'
#     else
#      render 'new',
#      status: :unprocessable_entity, notice: 'Could not create comment'
#     end
#   end

# OLD DESTROY METHOD
# def destroy
#     @post = Post.find(params[:post_id])
#     @comment = @post.comments.find(params[:id]) do |c|
#       c.user = User.find(params[:user_id])
#     end
#
#     if @comment.destroy
#       redirect_to @post
#       flash.now[:notice] = "Comment Has Been Deleted!"
#     else
#       flash.now[:notice] = "Couldn't Delete The Comment!"
#     end
#   end

# OLD NEW METHOD
# def new
#     @post = Post.find(params[post_id])
#     @comment = @post.comments.new do |c|
#       c.user = current_user
#     end
#   end

