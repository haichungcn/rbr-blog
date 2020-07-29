class CommentsController < ApplicationController
  before_action :require_user
  
  def create
    @article = Article.find(params[:article_id])
    @comment = Comment.new(body: comment_params[:body], user_id: current_user.id)
    @article.comments.append(@comment)
    redirect_to article_path(@article)
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    if current_user == @comment.user
      @comment.destroy
    else
      flash[:warning] = "You don't have the authorization to perform this action"
    end
    redirect_to article_path(@article)
  end

  private
  def comment_params
    params.require(:comment).permit(:body)
  end

end
