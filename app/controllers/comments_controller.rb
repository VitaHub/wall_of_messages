class CommentsController < ApplicationController
	before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :correct_user, only: [:edit, :update]
	@@parent_id = 0
	@@parent_type = ''

	def new
		@comment = Comment.new
		@@parent_id = params[:id]
		@@parent_type = params[:parent]
    respond_to do |format|
      format.html {redirect_to messages_path}
      format.js {}
    end
	end

	def create
		if @@parent_type == 'message'
			parent = Message.find_by(id: @@parent_id)
      @comment = parent.comments.build(message_params)
    else
      parent = Comment.find_by(id: @@parent_id)
      @comment = parent.children.create(message_params)
		end
		@comment.user_id = current_user.id
    if @comment.save
      sync_new @comment, scope: parent
    end
    respond_to do |format|
        format.html { redirect_to messages_path }
        format.js {head :ok}
    end
	end

	def edit
    @comment = Comment.find(params[:id])
    respond_to do |format|
      format.html {redirect_to messages_path}
      format.js {}
    end
  end

  def update
  	@comment = Comment.find(params[:id])
    if @comment.update_attributes(message_params)
      sync_update @comment
    end
    respond_to do |format|
        format.html { redirect_to messages_path }
        format.js {head :ok}
    end
  end

  private
  def message_params
    params.require(:comment).permit(:body)
  end
  
    # Check if user is correct
  def correct_user 
    unless current_user.id == Comment.find(params[:id]).user_id
      render json: nil, status: :ok
    end
  end
end