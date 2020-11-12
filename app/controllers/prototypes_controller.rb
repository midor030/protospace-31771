class PrototypesController < ApplicationController
  before_action :move_to_index, except: [:index, :show]

  def index
    @prototypes = Prototype.all
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.find(params[:prototype_id])
    @comment = @prototype.comments.new(comment_params)
    if @comment.save
      redirect_to prototype_path(@prototype)
    else
      render :show
    end
  end

  def edit
    @prototype = Prototype.find(params[:id])
  end

  def update
    @prototype = Prototype.find(params[:id])
    if @prototype.update(prototype_params)
      redirect_to prototype_path
    else
      render :edit
    end
  end

  def destroy
    @prototype = Prototype.find(params[:id])
    @prototype.delete
    redirect_to root_path
  end

  private
  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id)
  end
end
