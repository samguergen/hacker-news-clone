class CommentsController < ApplicationController

  def index
    @the_post = Post.find_by(id: params[:post_id])
  end

  def show
    # @the_post = Post.find_by(id: params[:post_id])
  end

  def new
    @new_comment = Comment.new
  end

  def create
    @the_post = Post.find_by(id: params[:post_id])
    @new_comment = Comment.create!(comment_params)
    redirect_to post_path
  end

  def edit
    @the_post = Post.find_by(id: params[:post_id])
    @the_comment = @the_post.comments.find_by(id: params[:id])
  end

  def update
    @the_post = Post.find_by(id: params[:post_id])
    @the_comment = @the_post.comments.find_by(id: params[:id])
    if current_user == @the_post.user || current_user == @the_comment.user
      @the_comment.update_attributes(comment_params)
      redirect_to post_path(@the_post)
    else
      redirect_to root_path
    end
  end

  def destroy
    @the_post = Post.find_by(id: params[:post_id])
    @the_comment = @the_post.comments.find_by(id: params[:id])
    if current_user == @the_post.user || current_user == @the_comment.user
      @the_comment.destroy!
      redirect_to post_path
    else
      redirect_to root_path
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content).merge(user: current_user, post: @the_post )
  end

end
