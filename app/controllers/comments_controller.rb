class CommentsController < ApplicationController
  def create
    
  end

  private
  def comment_params
  params.require(:comment).permit(:title).merge(user_id: current_user.id, prototype_id: params[:prototype_id])

end
