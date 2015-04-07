class PostsController < ApplicationController

  def index
    @all_posts = Post.all
  end

  def show
    @the_post = Post.find_by(id: params[:id])
  end

  def new
    @new_post = Post.new
  end

  def create
    @new_post = Post.create!(post_params)
    redirect_to "/posts/#{@new_post.id}"
  end

  def edit
    @the_post = Post.find_by(id: params[:id])
  end

  def update
    @the_post = Post.find_by(id: params[:id])
    if current_user == @the_post.user
      @the_post.update_attributes(title: params[:title], content: params[:content])
      redirect_to post_path
    else
      redirect_to root_path
    end
  end

  def destroy
    @the_post = Post.find_by(id: params[:id])
    if current_user == @the_post.user
      @the_post.destroy!
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :content).merge(user: current_user)
  end
end

