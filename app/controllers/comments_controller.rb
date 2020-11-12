class CommentsController < ApplicationController
  def create
    @comment = Comments.new(comment_params)
    if @comment.save
      redirect_to "/prototypes/#{comment.prototype_id}"
    else
      @prototype = @comment.prototype
      @comments = @prototype.comments
      render prototype_path
    end
  end

  private
  def comment_params
   params.require(:comment).permit(:text).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end
end
