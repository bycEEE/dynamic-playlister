class ChatMessagesController < ApplicationController

	def create
		@chat_message = ChatMessage.create(chat_message_params)
		# Temp.broadcast("/chat_messages/#{@chat_message.playlist.id}", @chat_message)
		Temp.broadcast("/chat_messages/#{@chat_message.playlist.id}", @chat_message)
		render :nothing => true
	end

	private
	def chat_message_params
		params.require(:chat_message).permit(:content, :playlist_id, :user_id)
	end
end
