class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to root_path
    else
      render "prototypes/show"
    end
  end
  end

  private
  def comment_params
  params.require(:comment).permit(:title).merge(user_id: current_user.id, prototype_id: params[:prototype_id])

end
