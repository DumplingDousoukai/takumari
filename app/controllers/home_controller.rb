class HomeController < ApplicationController

  def top
    if user_signed_in?
      @room = Room.new
      @rooms = current_user.rooms
      @nonrooms = Room.where(id: UserRoom.where.not(user_id: current_user.id).pluck(:id))
    end
  end

end
