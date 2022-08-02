class MemosController < ApplicationController
  def show
    @place_id = params[:place_id]
    @shop   = Shop.find_by(place_id: @place_id)
    @memo   = Memo.find_by(place_id: @place_id, user_id: current_user.id)
  end

  def update
    puts "PLACE => #{params[:place_id]}, USER => #{params[:user_id]}, MEMO => #{params[:memo]}"

    # メモの更新
    if !params[:memo].nil?
      @memo = Memo.find_by(place_id: params[:place_id], user_id: current_user.id)
      puts "FAVORITE => #{@memo.favorite}"
      if @memo.update(memo:params[:memo])
        # 更新に成功した場合を扱う。
        puts "SEIKO========================"
        redirect_to request.referer
      end
    end

    # 回数の更新
    if !params[:count].nil?
      @memo = Memo.find_by(place_id: params[:place_id], user_id: current_user.id)
      puts "FAVORITE => #{@memo.favorite}"
      if @memo.update(count: @memo.count + 1)
        # 更新に成功した場合を扱う。
        puts "COUNTUP!========================"
        redirect_to request.referer
      end
    end

    # お気に入り変更
    if !params[:favo].nil?
      @memo = Memo.find_by(place_id: params[:place_id], user_id: current_user.id)
      if @memo.favorite < 3 then @memo.favorite += 1
      else @memo.favorite = 0
      end
      if @memo.update(favorite: @memo.favorite)
        # 更新に成功した場合を扱う。
        puts "COUNTUP!========================"
        redirect_to request.referer
      end
    end    
  end
end
