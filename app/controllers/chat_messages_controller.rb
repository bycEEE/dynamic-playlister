class ChatMessagesController < ApplicationController

	def create
		@chat_message = ChatMessage.create(chat_message_params)
		# Temp.broadcast("playlists/#{@chat_message.playlist.id}/chat_messages", @chat_message)
		Temp.broadcast("playlists/#{@chat_message.playlist.id}/chat_messages", @chat_message)
		binding.pry
		render :nothing => true
	end

	private
	def chat_message_params
		params.require(:chat_message).permit(:content, :playlist_id, :user_id)
	end
end