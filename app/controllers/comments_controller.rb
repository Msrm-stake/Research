class CommentsController < ApplicationController
  before_action :set_article

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.new(comment_params)
    @comment.user = current_user

    if params[:comment][:parent_comment_id].present?
      @comment.parent_comment_id = params[:comment][:parent_comment_id]
    end

    if @comment.save
      redirect_to @article, notice: 'Comment was successfully created.'
    else
      redirect_to @article, alert: 'Error creating comment.'
    end
  end

  def reply
    @article = Article.find(params[:article_id])
    @comment = @article.comments.new(comment_params)
    @comment.user = current_user
    @comment.parent_comment_id = params[:id] # This is the comment being replied to.
  
    if @comment.save
      redirect_to @article, notice: 'Reply was successfully posted.'
    else
      redirect_to @article, alert: 'Error posting reply.'
    end
  end

  private

  def set_article
    @article = Article.find(params[:article_id])
  end

  def comment_params
    params.require(:comment).permit(:body, :parent_comment_id)
  end
end
