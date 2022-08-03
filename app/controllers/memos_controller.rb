class MemosController < ApplicationController
  protect_from_forgery 
  def show
    if user_signed_in?
      @place_id = params[:place_id]
      @shop   = Shop.find_by(place_id: @place_id)
      @memo   = Memo.find_by(place_id: @place_id, user_id: current_user.id)

    else
      redirect_to root_path
    end
  end

  def update

    # user_signed_in 及び　current_user.idが動かないので妥協策としてparms[:user_id]を使用する
    if user_signed_in? || params[:user_id]
      # @memo = Memo.find_by(place_id: params[:place_id], user_id: current_user.id)
      @memo = Memo.find_by(place_id: params[:place_id], user_id: params[:user_id])
      # メモの更新
      if !params[:memo].nil?
        puts "FAVORITE => #{@memo.favorite}"
        if @memo.update(memo:params[:memo])
          # 更新に成功した場合を扱う。
          puts "SEIKO========================"
          redirect_to request.referer
        end
      end

      # 回数の更新
      if !params[:count].nil?
        puts "FAVORITE => #{@memo.favorite}"
        if @memo.update(count: @memo.count + 1)
          # 更新に成功した場合を扱う。
          puts "COUNTUP!========================"
          redirect_to request.referer
        end
      end

      # お気に入り変更
      if !params[:favo].nil?

        if @memo.favorite < 3 then @memo.favorite += 1
        else @memo.favorite = 0
        end
        if @memo.update(favorite: @memo.favorite)
          # 更新に成功した場合を扱う。
          puts "COUNTUP!========================"
          redirect_to request.referer
        end
      end
    else
      puts "ERRORRRRRRRRRRRR@@@@@@@@@@@@@@@@@@@@@@"  
      puts current_user.id
      redirect_to request.referer
    end
  end
end
