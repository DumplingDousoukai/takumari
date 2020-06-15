class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    message = Message.new(content: data['message'][0], user_id: data['message'][1].to_i, room_id: data['message'][2].to_i)
    message.save
    ActionCable.server.broadcast 'room_channel', message: data['message'][0]
  end
end
