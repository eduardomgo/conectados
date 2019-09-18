include PostsHelper
class PostsController < ApplicationController
  before_action :set_post, only: [:like, :delete_comment, :comment, :show, :edit, :update, :destroy]
  before_action :protect_edition, only: [:edit, :update]
  before_action :protect_destroy, only: :destroy
  before_action :protect_destroy_comment, only: :delete_comment
  before_action :block_non_logged

  # GET /posts
  # GET /posts.json
  def index
    @ids_aux = friendships(current_user)
    @ids = []
    @ids_aux.each do |t|
      @ids.push(t[1])
    end
    puts @ids
    @posts = Post.where(user_id: @ids).order(created_at: :desc).paginate(page: params[:page], per_page: 9)
  end

  def like
    @like = Like.find_by(user_id: current_user.id, post_id: @post.id)
    if @like
      @like.destroy
    else
      @like = Like.create(user_id: current_user.id, post_id: @post.id)
    end
    redirect_to post_path(@post.id)
  end


  def comment
    @comment = Comment.new(content: params[:comment][:content])
    @comment.post_id = @post.id
    @comment.user_id = current_user.id
    @comment.save
    redirect_to post_path(@post.id)
  end

  def delete_comment

    @comment = Comment.find(params[:comment_id])
    if @comment.user_id == current_user.id or current_user.adm == false
      @comment.destroy
    end
    redirect_to post_path(@post.id)
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @like = Like.find_by(user_id: current_user.id, post_id: @post.id)
    @likes = Like.where(post_id: @post.id).count()
    @comments = Comment.where(post_id: @post.id).paginate(page: params[:page], per_page: 6)
    @comment = Comment.new
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:content, :image, :user_id)
    end

    def comment_params
      params.permit(:content, :post_id, :user_id)
    end
end
