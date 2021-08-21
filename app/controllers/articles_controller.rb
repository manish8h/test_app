class ArticlesController < ApplicationController

  before_action :set_article, only: [:edit,:update,:show, :destroy]

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    #to show plain text
    # render plain: params[:article].inspect
    @article = Article.new(article_params)
    # binding.pry
    #hard coded to by pass user id
    @article.user = User.first

    if @article.save
      flash[:success] = "Article was successfully created!"
      redirect_to article_path(@article)
    else
      render :new
    end
  end

  def show
    # @article = Article.find(params[:id])
  end

  def edit
    # @article = Article.find(params[:id])
  end

  def update
    # @article = Article.find(params[:id])

    if @article.update(article_params)
      flash[:success] = "Article was successfully Updated!"
      redirect_to article_path(@article)
    else
      render :edit
    end
  end

  def destroy
    # @article = Article.find(params[:id])
    @article.destroy
    flash[:danger] = "Article was successfully Deleted"
    redirect_to articles_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :description)
  end

  def set_article
    @article = Article.find(params[:id])
  end

end