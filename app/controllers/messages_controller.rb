class MessagesController < ApplicationController
	before_action :authenticate_user!, only: [:create, :edit, :update]

  def index
    @messages = Message.all.order(created_at: :desc)
    @new_message = Message.new
  end

  def create
    @message = current_user.messages.build(message_params)
    if @message.save
      sync_new @message
    end
    respond_to do |format|
        format.html { redirect_to messages_path }
        format.js {head :no_content}
    end
  end

  def edit
    @message = Message.find(params[:id])
    respond_to do |format|
      format.html {redirect_to messages_path}
      format.js {}
    end
  end

  def update
  	@message = Message.find(params[:id])
    if @message.update_attributes(message_params)
      sync_update @message
    end
    respond_to do |format|
        format.html { redirect_to messages_path }
        format.js {head :ok}
    end
  end

  private
    def message_params
      params.require(:message).permit(:body)
    end
end
