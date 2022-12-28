class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy]
  before_action :ensure_user, only: [:edit, :update, :destroy]

  def index
    @blogs = Blog.all
  end

  def new
    if params[:back]
      @blog = Blog.new(post_params)
    else
      @blog = Blog.new
    end
  end

  def create
    @blog = current_user.blogs.build(blog_params)
    if params[:back]
      render :new
    else
      if @blog.save
        BlogMailer.blog_mail(@blog).deliver
        redirect_to blogs_path, notice: "ブログを作成しました！"
      else
        render :new
      end
    end
  end

  def show
    #@blog = Blog.find(params[:id])
    @favorite = current_user.favorites.find_by(blog_id: @blog.id)
  end

  def edit
    #@blog = Blog.find(params[:id])
  end

  def update
    #@blog = Blog.find(params[:id])
    if @blog.update(blog_params)
      redirect_to blogs_path, notice: "ブログを編集しました！"
    else
      render :edit
    end
  end

  def destroy
    @blog.destroy
    redirect_to blogs_path, notice:"ブログを削除しました！"
  end

  def confirm
    @blog = current_user.blogs.build(blog_params)
    render :new if @blog.invalid?
  end

  private

  def blog_params
    params.require(:blog).permit(:title, :content, :image, :image_cache)
  end

  def set_blog
    @blog = Blog.find(params[:id])
  end

  def ensure_user
    @blogs = current_user.blogs
    @blog = @blogs.find_by(id: params[:id])
    redirect_to new_blog_path unless @blog
  end

end