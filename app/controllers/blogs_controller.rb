class BlogsController < ApplicationController

  before_action :set_blog, only: [:edit,:update,:show, :destroy]

  def index
    @blogs = Blog.all
  end

  def new
    @blog = Blog.new
  end

  def create
    #to show plain text
    # render plain: params[:article].inspect
    @blog = Blog.new(blog_params)

    if @blog.save
      flash[:notice] = "Blog was successfully created!"
      redirect_to blog_path(@blog)
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @blog.update(blog_params)
      flash[:notice] = "Article was successfully Updated!"
      redirect_to blog_path(@blog)
    else
      render :edit
    end
  end

  def destroy
    @blog.destroy
    flash[:notice] = "Blog was successfully Deleted"
    redirect_to blogs_path
  end

  private

  def blog_params
    params.require(:blog).permit(:title, :description)
  end

  def set_blog
    @blog = Blog.find(params[:id])
  end

end