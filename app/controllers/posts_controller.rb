class PostsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_post, only: %i[show edit update destroy]

  def index
    @posts = Post.all
  end

  def show; end

  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit; end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params.merge(user: current_user))

    respond_to do |format|
      if @post.save
        # flash.now[:notice] = 'Post was successfully created.'
        # format.turbo_stream {
        #   render turbo_stream: [
        #     turbo_stream.append('posts', partial: 'posts/post', locals: { post: @post }),
        #     turbo_stream.replace('posts', partial: 'posts/form', locals: { post: Post.new }),
        #     render_turbo_flash
        #   ]
        # }
        format.html { redirect_to post_url(@post), notice: 'Post was successfully created.' }
      else
        # flash.now[:alert] = 'Post could not be created.'
        # format.turbo_stream {
        #   render turbo_stream: [
        #     turbo_stream.replace('posts', partial: 'posts/form', locals: { post: @post }),
        #     render_turbo_flash
        #   ]
        # }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params.merge(user: current_user))
        # flash.now[:notice] = 'Post was successfully updated.'
        # format.turbo_stream {
        #   render turbo_stream: [
        #     turbo_stream.replace('post', partial: 'posts/post', locals: { post: @post }),
        #     render_turbo_flash
        #   ]
        # }
        format.html { redirect_to post_url(@post), notice: 'Post was successfully updated.' }
      else
        flash.now[:alert] = 'Post could not be updated.'
        # format.turbo_stream {
        #   render turbo_stream: [
        #     turbo_stream.replace('post', partial: 'posts/form', locals: { post: @post }),
        #     render_turbo_flash
        #   ]
        # }
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy

    respond_to do |format|
      # format.turbo_stream { render turbo_stream: turbo_stream.remove(@post) }
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :description, :published)
  end
end
