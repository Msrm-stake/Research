class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def new
    @article = Article.new
  end

  def create
    @community = current_user.community # Use `.community` instead of `.communities`
    
    if @community.nil?
      redirect_to new_community_path, alert: 'You need to create a community first.'
      return
    end
  
    @article = @community.articles.new(article_params.merge(user: current_user))
    
    if @article.save
      redirect_to @article, notice: 'Article was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end
  

  def upload_image
    uploaded_image = params[:file]
    image = Rails.application.routes.url_helpers.rails_blob_path(
      ActiveStorage::Blob.create_and_upload!(io: uploaded_image, filename: uploaded_image.original_filename),
      only_path: true
    )
    render json: { location: image }
  end


  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
    @community = @article.community
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    if @article.update(article_params)
      redirect_to @article, notice: 'Article was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path, notice: 'Article was successfully deleted.'
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :status, :photo, :body, :video)
  end
end
