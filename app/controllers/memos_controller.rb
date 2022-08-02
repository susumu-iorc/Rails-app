class MemosController < ApplicationController
  def show
    @place_id = params[:place_id]
    @shop   = Shop.find_by(place_id: @place_id)
    @memo   = Memo.find_by(place_id: @place_id, user_id: current_user.id)
  end

  def update
    puts "PLACE => #{params[:place_id]}, USER => #{params[:user_id]}, MEMO => #{params[:memo]}"
    #if current_user.id == params[:user_id]
      @memo = Memo.find_by(place_id: params[:place_id], user_id: current_user.id)
      puts "FAVORITE => #{@memo.favorite}"
      if @memo.update(memo:params[:memo])
        # 更新に成功した場合を扱う。
        puts "SEIKO========================"
        redirect_to request.referer
      end
     #end
  end
end
