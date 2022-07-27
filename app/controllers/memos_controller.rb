class MemosController < ApplicationController
  def show
    @place_id = params[:place_id]
    @shop   = Shop.find_by(place_id: @place_id)
    @memo   = Memo.find_by(place_id: @place_id, user_id: current_user.id)
  end
end
